import typing
import pandas as pd
import geopandas as gpd


def load_files() -> dict[str, typing.Union[pd.DataFrame, gpd.GeoDataFrame]]:
    """Utility function to load both data files.

    Returns:
        pd.DataFrame containing geocoded_case_archives
        and
        gpd.GeoDataFrame containing land_use polygons
    """
    df = pd.read_csv("./data/case_archives_distances.csv", low_memory=False)
    land_use_map = gpd.read_file("./data/LANDUSE_SHAPES/land_use.shp")
    land_use_map.drop(
        [
            "FIRST_COUN",
            "LANDUSE",
            "LANDUSE2",
            "OS_MGMT",
            "FAC_NAME",
            "PLATTED",
            "MODIFIER",
            "Shape_Leng",
            "Shape_Area",
        ],
        axis=1,
        inplace=True,
    )
    return {"case_archives": df, "land_use": land_use_map}


def make_point_geometries(dataframe: pd.DataFrame) -> gpd.GeoDataFrame:
    """[summary]

    Args:
        dataframe (pd.DataFrame): [description]

    Returns:
        gpd.GeoDataFrame: [description]
    """
    df = dataframe[dataframe.coded_lat.notna()]
    geo_df = gpd.GeoDataFrame(
        df, geometry=gpd.points_from_xy(df.coded_long, df.coded_lat), crs="EPSG:4326"
    )
    return geo_df


def spatially_join(
    point_df: gpd.GeoDataFrame, polygon_df: gpd.GeoDataFrame
) -> gpd.GeoDataFrame:
    """[summary]

    Args:
        point_df (gpd.GeoDataFrame): [description]
        polygon_df (gpd.GeoDataFrame): [description]

    Returns:
        gpd.GeoDataFrame: [description]
    """
    geo_points = point_df.to_crs(polygon_df.crs)
    merged_data = gpd.sjoin(geo_points, polygon_df, how="left")
    return merged_data


def write_joined_file(geo_dataframe: gpd.GeoDataFrame):
    """Utility function to write geodataframe to file."""
    geo_dataframe.to_csv("./data/joined_records.csv", index=False)
