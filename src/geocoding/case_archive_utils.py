import re
from typing import Union

import pandas as pd
from geopy import distance
from geopy.extra.rate_limiter import RateLimiter
from geopy.geocoders import ArcGIS
from sodapy import Socrata
from tqdm import tqdm

tqdm.pandas()


def get_live_case_archive_data() -> pd.DataFrame:
    """Loads live data from cook county api via socrata (sodapy).

    Returns:
        pd.DataFrame: Dataframe of records.
    """
    client = Socrata("datacatalog.cookcountyil.gov", None)
    results = client.get("cjeq-bs86", limit=100_000)  # id for case archives dataset
    results_df = pd.DataFrame.from_records(results)

    # drop where incident_street is None
    df = results_df[results_df["incident_street"].notna()]

    # regex removal
    df["clean_address"] = df.apply(lambda row: clean_address(row), axis=1)
    df = df[df["clean_address"].notna()]

    # subs city if needed and combines address fields
    addresses = df.apply(lambda row: create_address(row), axis=1)
    df["full_address"] = [a[0] for a in addresses]
    df["city_subbed"] = [a[1] for a in addresses]
    return df


def deal_with_commas(x: str) -> str:
    """Handles commas, stripping and title-casing in Address field.

    Args:
        x (str): Address

    Returns:
        str: Cleaned address
    """
    if "," not in x:
        return x.strip().title()

    # TODO: debug
    # ! what is this second section of code doing?
    parts = x.split(",")
    result = " ".join([z for z in parts if any(y for y in z if y.isnumeric())])
    return result.strip().title()


def remove_apartment_info(x: str) -> str:
    """Uses regex to remove # and Apt from Address

    Args:
        x (str): Address

    Returns:
        str: Cleaned address
    """
    # regex 1 to look for apartments and #s
    result1 = re.sub(r"apt.*|\#.*|.*nh,", "", x)
    # regex 2 to specify only alphanumeric + '.' for abbreviations and spaces
    result2 = re.sub(r"[^a-zA-Z0-9.\s]", "", result1)
    return result2


def clean_address(row: pd.Series) -> Union[int, str, None]:
    """Cleans an address by calling other utility functions.

    Args:
        row (pd.Series): row in a dataframe

    Returns:
        Union[int, str, None]: cleaned address or None
    """
    a = row["incident_street"]
    # handles 'unknown' and variations
    if "unk" in a.lower():
        return None
    no_apartment_info = remove_apartment_info(a.lower())
    no_commas = deal_with_commas(no_apartment_info)
    return no_commas


def city_sub(row: pd.Series) -> tuple[str, bool]:
    """Identifies whether a city substitution can be used.

    This function handles cases where the incident_city is null
    and it looks for a city in residence_city.  If there is one,
    it subsitutes the latter for the former.

    Args:
        row (pd.Series): row in a dataframe

    Returns:
        tuple[str, bool]: a tuple containing the city and whether it was subsituted
    """
    if pd.notna(row["incident_city"]):
        city = row["incident_city"].title().strip()
        subbed = False
    elif pd.isna(row["incident_city"]) and pd.notna(row["residence_city"]):
        city = row["residence_city"].title().strip()
        subbed = True
    else:
        city = ""
        subbed = False
    return city, subbed


def create_address(row: pd.Series) -> tuple[str, bool]:
    """Creates the address field column for each row of a dataframe.

    Calls city_sub.

    Args:
        row (pd.Series): row in a dataframe.

    Returns:
        tuple[str, bool]: cleaned address and whether a city substitution was performed.
    """
    street = row["clean_address"]
    city, city_subbed = city_sub(row)
    zip_code = "" if pd.isna(row["incident_zip"]) else row["incident_zip"].strip()
    address = f"{street} {city} {zip_code}"
    return address.strip(), city_subbed


def geocode_case_archive(df: pd.DataFrame) -> pd.DataFrame:
    """Geocodes each row in the case archives dataframe.

    This function takes the full address column and geocodes it.

    The resulting dataframe has three new columns: coded_lat, coded_long,
    and coded_score.

    Args:
        df (pd.DataFrame): case archives dataframe.

    Returns:
        pd.DataFrame: geocoded dataframe.
    """
    geolocator = ArcGIS()
    df["geo_location"] = df["full_address"].progress_apply(geolocator.geocode)
    df["coded_lat"] = df["geo_location"].apply(
        lambda x: x.latitude if pd.notna(x) else None
    )
    df["coded_long"] = df["geo_location"].apply(
        lambda x: x.longitude if pd.notna(x) else None
    )
    df["coded_score"] = df["geo_location"].apply(
        lambda x: x.raw.get("score") if pd.notna(x) else None
    )
    df.drop("geo_location", axis=1, inplace=True)
    return df


def calculate_distance(df: pd.DataFrame) -> pd.DataFrame:
    """Calculates distance from original lat/long to geocoded lat/long.

    Args:
        df (pd.DataFrame): original df

    Returns:
        pd.DataFrame: dataframe with distance column
    """

    def calc_distance(row) -> Union[None, float]:
        if (
            pd.isna(row.latitude)
            or pd.isna(row.longitude)
            or pd.isna(row.coded_lat)
            or pd.isna(row.coded_long)
        ):
            return None
        # distance in miles
        d = distance.distance(
            (row.latitude, row.longitude), (row.coded_lat, row.coded_long)
        ).mi
        return d

    df["distance"] = df.apply(lambda row: calc_distance(row), axis=1)
    return df


def dump_case_archive_data(df: pd.DataFrame):
    """Dumps the provided dataframe to file."""
    df.to_csv("./data/geocoded_case_archives.csv", index=False)
