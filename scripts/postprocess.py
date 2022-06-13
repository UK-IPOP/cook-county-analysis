from __future__ import annotations

import pandas as pd
import geocoding
from scourgify import normalize_address_record
from scourgify.exceptions import UnParseableAddressError
import numpy as np


def load_cases() -> pd.DataFrame:
    return pd.read_csv("data/processed/spatially_joined_records.csv", low_memory=False)


def label_landuse(df: pd.DataFrame) -> pd.DataFrame:
    data = pd.read_csv("./data/raw/landuse_data_dictionary.csv")
    data.set_index("landuse_id", inplace=True)
    data_dict = data.to_dict("index")
    df["landuse_name"] = df.LANDUSE.apply(
        lambda x: data_dict[x]["name"] if pd.notna(x) else None
    )
    df["landuse_sub_name"] = df.LANDUSE.apply(
        lambda x: data_dict[x]["sub_name"] if pd.notna(x) else None
    )
    df["landuse_major_name"] = df.LANDUSE.apply(
        lambda x: data_dict[x]["major_name"] if pd.notna(x) else None
    )
    return df


def merge_death_location_labels(df: pd.DataFrame) -> pd.DataFrame:
    death_locations = pd.read_csv("data/raw/death_locations.csv", low_memory=False)
    death_locations.columns = death_locations.columns.str.lower()
    death_addresses = death_locations.apply(
        lambda row: geocoding.geocode.create_address(row, "death"), axis=1
    )
    death_locations["death_address"] = [a[0] for a in death_addresses]
    # COMPARE death address to incident address
    combined = df.merge(
        death_locations.drop(columns=["death_date", "incident_date"]),
        how="left",
        on="casenumber",
    )
    combined["incident_matches_death"] = (
        combined.incident_address == combined.death_address
    )
    return combined


def flag_is_duplicated(df: pd.DataFrame) -> np.ndarray:
    """
    Flags cases that are duplicated.

    Returns a mask of booleans indicating whether a case is duplicated based on its index
    in the original df provided.
    """
    # initial duplicates
    duped_addrs = df[
        df.incident_address.duplicated(keep=False)
    ].incident_address.dropna()
    normalized_addrs = []
    for i, addr in duped_addrs.iteritems():
        try:
            normal = normalize_address_record(addr)
            normal_string = " ".join(y for y in normal.values() if y)
            normalized_addrs.append((i, normal_string, True, "valid"))
        except UnParseableAddressError:
            normalized_addrs.append((i, addr, False, "unparseable"))
        except ValueError:
            normalized_addrs.append((i, addr, False, "invalid"))

    address_df = pd.DataFrame(
        normalized_addrs,
        columns=["lookup_index", "normalized_address", "valid", "reason"],
    )
    valid_addresses = address_df[address_df.valid == True]
    valid_unique_indices = valid_addresses[
        valid_addresses.normalized_address.duplicated(keep=False)
    ].lookup_index
    mask = df.index.isin(valid_unique_indices)
    return mask


def preprocess(df: pd.DataFrame) -> pd.DataFrame:
    df = label_landuse(df)
    df = extract_date_data(df)
    df["motel"] = df.incident_address.apply(lambda x: classify_hotels(x))
    df["hot_combined"] = df.apply(lambda row: make_hot_cold(row, "hot"), axis=1)
    df["cold_combined"] = df.apply(lambda row: make_hot_cold(row, "cold"), axis=1)

    # make primary cause col combined
    df["primary_combined"] = df.apply(lambda row: join_cols(row), axis=1)

    # flag duplicates
    df["repeat_address"] = flag_is_duplicated(df)

    # remove unwanted cols
    not_needed_cols = [
        "incident_city",
        "incident_zip",
        "location",
        "latitude",
        "longitude",
        "objectid",
        "chi_ward",
        "chi_commarea",
        "geocoded_latitude",
        "geocoded_longitude",
        # new cols
        "LANDUSE2",
        "OS_MGMT",
        "FAC_NAME",
        "PLATTED",
        "MODIFIER",
        "TRACTCE",
        "NAME",
        "NAMELSAD",
        "MTFCC",
        "FUNCSTAT",
        "ALAND",
        "AWATER",
        "COMMENT",
        "death_city",
        "death_state",
        "death_zip",
    ]

    df = merge_death_location_labels(df)
    df.drop(not_needed_cols, axis=1, inplace=True)
    df = clean_data(df)
    return df


def join_cols(row) -> str:
    """Joins various column values."""
    return f"{row['primarycause'] if pd.notna(row['primarycause']) else ''}{row['primarycause_linea'] if pd.notna(row['primarycause_linea']) else ''}{row['primarycause_lineb'] if pd.notna(row['primarycause_lineb']) else ''}{row['primarycause_linec'] if pd.notna(row['primarycause_linec']) else ''}"


def extract_date_data(dff: pd.DataFrame) -> pd.DataFrame:
    df = dff.copy()
    df["death_datetime"] = df.death_date.apply(lambda x: pd.to_datetime(x))
    df["death_time"] = df.death_datetime.apply(
        lambda x: x.time() if pd.notna(x) else pd.NA
    )
    df["death_date"] = df.death_datetime.apply(lambda x: x.date())
    df["death_year"] = df.death_date.apply(lambda x: x.year)
    df["death_month"] = df.death_date.apply(lambda x: x.month)
    df["death_day"] = df.death_date.apply(lambda x: x.day)
    df["death_week"] = df.death_datetime.dt.isocalendar().week
    return df


def resolve_room(x: str) -> bool:
    if "room" in x.lower():
        # find index for word
        words = x.lower().split()
        index = next((i for i, word in enumerate(words) if word == "room"), None)
        if index and words[index + 1][0].isnumeric():
            return True
    return False


def classify_hotels(x: str) -> bool | None:
    if pd.isna(x):
        return None
    hotel_words = {"hotel", "motel", "holiday inn", "travel lodge"}
    if any(word in x.lower() for word in hotel_words):
        return True
    if resolve_room(x):
        return True
    return False


def make_hot_cold(row: pd.Series, x: str) -> bool:
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


def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    df = df.replace(to_replace={True: 1, False: 0})
    df = df.drop_duplicates(subset=["casenumber"])
    return df


def main():
    df = load_cases()
    df = preprocess(df)
    df.to_csv("data/processed/clean_cases.csv", index=False)


if __name__ == "__main__":
    main()
