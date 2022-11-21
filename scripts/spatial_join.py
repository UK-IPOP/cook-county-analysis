"""This program performs various spatial joins to the wide form dataset."""

import pandas as pd
import numpy as np
import geopandas
from pathlib import Path
from rich import print
from rich.progress import track


def load_records() -> pd.DataFrame:
    """Load the wide form dataset."""
    source_file = Path("data") / "secure" / "records_with_distances.jsonl"
    df = pd.read_json(source_file, lines=True, orient="records")
    return df


def apply_composite_lat_long(row) -> tuple[str | None, str | None]:
    """Apply the composite latitude and longitude to the dataframe."""
    if row["latitude"] and row["longitude"]:
        return row["latitude"], row["longitude"]
    elif row["geocoded_latitude"] and row["geocoded_longitude"]:
        return row["geocoded_latitude"], row["geocoded_longitude"]
    else:
        return None, None


def configure_source_data(df: pd.DataFrame) -> pd.DataFrame:
    """Configure the source data for the spatial joins."""
    coordinates = df.apply(apply_composite_lat_long, axis=1)
    dff = df.copy()
    dff["composite_latitude"] = coordinates.apply(lambda x: x[0])
    dff["composite_longitude"] = coordinates.apply(lambda x: x[1])
    return dff


def convert_to_geodataframe(df: pd.DataFrame) -> geopandas.GeoDataFrame:
    """Convert the dataframe to a geodataframe using lat/long."""
    geo_df = geopandas.GeoDataFrame(
        data=df,
        geometry=geopandas.points_from_xy(
            df["composite_longitude"],
            df["composite_latitude"],
            crs="EPSG:4326",
        ),
    )
    return geo_df


def label_landuse(df: pd.DataFrame) -> pd.DataFrame:
    """Label the landuse of the death location."""
    fpath = Path("data") / "secure" / "source" / "landuse_data_dictionary.csv"
    data = pd.read_csv(fpath)
    data.set_index("landuse_id", inplace=True)
    data_dict = data.to_dict("index")
    dff = df.copy()
    dff["landuse_name"] = dff.LANDUSE.apply(
        lambda x: data_dict[int(x)]["name"] if pd.notna(x) else None
    )
    dff["landuse_sub_name"] = dff.LANDUSE.apply(
        lambda x: data_dict[int(x)]["sub_name"] if pd.notna(x) else None
    )
    dff["landuse_major_name"] = dff.LANDUSE.apply(
        lambda x: data_dict[int(x)]["major_name"] if pd.notna(x) else None
    )
    return dff


def merge_death_location_labels(df: pd.DataFrame) -> pd.DataFrame:
    """Merge the death location labels to the dataframe."""
    fpath = Path("data") / "secure" / "source" / "death_locations.csv"
    death_locations = pd.read_csv(fpath, low_memory=False)
    death_locations.columns = death_locations.columns.str.lower()

    combined = df.merge(
        death_locations.drop(columns=["death_date", "incident_date"]),
        how="left",
        on="casenumber",
    )
    # very confusing syntax created here by `black`
    combined["incident_matches_death"] = np.where(
        (
            (combined["incident_street"] == combined["death_street"])
            & (combined["incident_city"] == combined["death_city"])
            & (combined["incident_zip"] == combined["death_zip"])
        ),
        True,
        False,
    )
    return combined


def merge_supplemental_data(df: pd.DataFrame) -> pd.DataFrame:
    """Merge the supplemental data to the dataframe."""
    community_population = pd.read_csv(
        "https://datahub.cmap.illinois.gov/dataset/1d2dd970-f0a6-4736-96a1-3caeb431f5e4/resource/0916f1de-ae37-4476-bf4e-6485ba08c975/download/Census2020SupplementCCA.csv"
    )
    dff = pd.merge(
        df, community_population, how="left", left_on="pri_neigh", right_on="GEOG"
    )
    return dff


def extract_date_data(df: pd.DataFrame) -> pd.DataFrame:
    """Extract the date data from the dataframe."""
    dff = df.copy()
    dff["death_datetime"] = dff.death_date.apply(lambda x: pd.to_datetime(x))
    dff["death_time"] = dff.death_datetime.apply(
        lambda x: x.time() if pd.notna(x) else pd.NA
    )
    dff["death_date"] = dff.death_datetime.apply(lambda x: x.date())
    dff["death_year"] = dff.death_date.apply(lambda x: x.year)
    dff["death_month"] = dff.death_date.apply(lambda x: x.month)
    dff["death_day"] = dff.death_date.apply(lambda x: x.day)
    dff["death_week"] = dff.death_datetime.dt.isocalendar().week
    dff["death_day_of_week"] = dff.death_datetime.dt.day_name()
    return dff


def classify_hotels(x: str) -> bool | None:
    """Classify the hotels."""
    if pd.isna(x) or type(x) != str:
        return None
    hotel_words = {"hotel", "motel", "holiday inn", "travel lodge"}
    if any(word in x.lower() for word in hotel_words):
        return True
    if "room " in x.lower():
        return True
    return False


def make_hot_cold(row: pd.Series, x: str) -> bool:
    """Make the hot/cold column."""
    if x == "hot":
        hot = row["heat_related"] if pd.notna(row["heat_related"]) else False
        secondary = row["secondarycause"] if pd.notna(row["secondarycause"]) else ""
        if "hot" in secondary.lower() or hot:
            return True
        return False
    elif x == "cold":
        cold = row["cold_related"] if pd.notna(row["cold_related"]) else False
        secondary = row["secondarycause"] if pd.notna(row["secondarycause"]) else ""
        if "cold" in secondary.lower() or cold:
            return True
        return False
    else:
        raise ValueError(f"{x} not valid value for hot/cold")


def duplicated_lat_long(df: pd.DataFrame) -> pd.DataFrame:
    """Check for duplicated lat/long."""
    dff = df.copy()
    dff["repeated_lat_long"] = dff.duplicated(
        subset=["composite_latitude", "composite_longitude"]
    )
    return dff


def main():
    urls_to_join = [
        "https://gis.cookcountyil.gov/traditional/rest/services/politicalBoundary/MapServer/2/query?outFields=*&where=1%3D1&f=geojson",  # municipalities
        "https://data.cityofchicago.org/api/geospatial/bbvz-uum9?method=export&format=GeoJSON",  # neighborhoods
        "https://gis.cookcountyil.gov/traditional/rest/services/cultural/MapServer/7/query?outFields=*&where=1%3D1&f=geojson",  # parks
    ]
    landuse_path = (
        Path("data") / "downloads" / "LUI15_shapefile_v1" / "Landuse2015_CMAP_v1.shp"
    )

    df = load_records()
    initial_cols = len(df.columns)

    configured_df = configure_source_data(df=df)
    geo_df = convert_to_geodataframe(df=configured_df)

    print(f"Starting shape -> Rows: {geo_df.shape[0]} Columns: {geo_df.shape[1]}")
    for url in track(urls_to_join, description="Performing Spatial Joins..."):
        gdf = geopandas.read_file(url).to_crs("EPSG:4326")
        geo_df = geopandas.sjoin(geo_df, gdf, how="left", predicate="within")
        geo_df.drop(columns=["index_right"], inplace=True, errors="ignore")
        print(f"Updated shape -> Rows: {geo_df.shape[0]} Columns: {geo_df.shape[1]}")

    print("Merging in supplemental data...")
    geo_df = merge_supplemental_data(df=geo_df)
    print(f"Updated shape -> Rows: {geo_df.shape[0]} Columns: {geo_df.shape[1]}")

    print("Now joining land use data..")
    landuse_df = geopandas.read_file(landuse_path).to_crs("EPSG:4326")
    geo_df = geopandas.sjoin(geo_df, landuse_df, how="left", predicate="within")
    del landuse_df  # because very large
    print(f"Updated shape -> Rows: {geo_df.shape[0]} Columns: {geo_df.shape[1]}")

    print("Now labeling land use data...")
    geo_df = label_landuse(df=geo_df)

    print("Now joining death location data...")
    geo_df = merge_death_location_labels(df=geo_df)

    print("Now extracting death date data...")
    geo_df = extract_date_data(df=geo_df)

    print("Classifying hotels/motels...")
    geo_df["hotel"] = geo_df.incident_street.apply(classify_hotels)

    print("Classifying hot/cold...")
    geo_df["hot"] = geo_df.apply(lambda x: make_hot_cold(row=x, x="hot"), axis=1)
    geo_df["cold"] = geo_df.apply(lambda x: make_hot_cold(row=x, x="cold"), axis=1)

    print("Classifying repeated lat/long...")
    geo_df = duplicated_lat_long(df=geo_df)

    print("Cleaning up booleans...")
    geo_df = geo_df.replace({True: 1, False: 0}).drop_duplicates(subset=["casenumber"])

    final_columns = len(geo_df.columns)
    print(
        f"Ultimately, we added {final_columns - initial_cols} columns to the dataset."
    )
    print("Writing to file...")
    out_dir = Path("data")
    out_dir.mkdir(exist_ok=True)
    geo_df.to_csv(out_dir / "records_with_spatial_data.csv", index=False)


if __name__ == "__main__":
    main()
