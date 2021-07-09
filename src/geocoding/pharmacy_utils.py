import pandas as pd
from geopy.geocoders import ArcGIS
from geopy.adapters import AioHTTPAdapter
from tqdm import tqdm
import asyncio

tqdm.pandas()


def make_pharmacy_address(row: pd.Series) -> str:
    """Utility function to combine fields into one address field.

    The row for this function should have PharmacyAddress, City, State, and Zip fields.
    Args:
        row (pd.Series): Row in a dataframe

    Returns:
        str: Concatenated string for full address
    """
    street = row["PharmacyAddress"]
    city = row["City"]
    state = row["State"]
    zip_code = row["Zip"]
    address = f"{street} {city} {state} {zip_code}".strip()
    return address


def load_pharmacy_data() -> pd.DataFrame:
    """Loads pharmacy datafile.

    Also makes 'full_address' column.

    Returns:
        pd.DataFrame: Loaded dataframe.
    """
    df = pd.read_csv("./data/CookCounty_Pharmacies.csv")
    df["full_address"] = df.apply(lambda row: make_pharmacy_address(row), axis=1)
    return df


def geocode_pharmacy(df: pd.DataFrame) -> pd.DataFrame:
    """Geocodes the pharmacies.

    Gets latitude, longitude, and accuracy score for each pharmacy.

    Args:
        df (pd.DataFrame): Pharmacy dataframe

    Returns:
        pd.DataFrame: Geocoded pharmacy dataframe.
    """
    geolocator = ArcGIS()
    df["geo_location"] = df["full_address"].progress_apply(geolocator.geocode)
    df["coded_lat"] = df["geo_location"].apply(lambda x: x.latitude)
    df["coded_long"] = df["geo_location"].apply(lambda x: x.longitude)
    df["coded_score"] = df["geo_location"].apply(lambda x: x.raw.get("score"))
    df.drop("geo_location", axis=1, inplace=True)
    return df


def dump_pharmacy_data(df: pd.DataFrame):
    """Utility function to dump geocoded dataframe to file."""
    df.to_csv("./data/geocoded_pharmacies.csv", index=False)
