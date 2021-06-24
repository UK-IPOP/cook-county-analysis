import pandas as pd
from geopy.extra.rate_limiter import RateLimiter
from geopy.geocoders import ArcGIS
from tqdm import tqdm

tqdm.pandas()


def make_pharmacy_address(row: pd.Series) -> str:
    street = row["PharmacyAddress"]
    city = row["City"]
    state = row["State"]
    zip_code = row["Zip"]
    address = f"{street} {city} {state} {zip_code}".strip()
    return address


def load_pharmacy_data() -> pd.DataFrame:
    df = pd.read_csv("./data/CookCounty_Pharmacies.csv")
    df["full_address"] = df.apply(lambda row: make_pharmacy_address(row), axis=1)
    return df


def geocode_pharmacy(df: pd.DataFrame) -> pd.DataFrame:
    geolocator = ArcGIS()
    geocode = RateLimiter(geolocator.geocode)  # default to 0.0 delay
    df["geo_location"] = df["full_address"].progress_apply(geocode)
    df["coded_lat"] = df["geo_location"].apply(lambda x: x.latitude)
    df["coded_long"] = df["geo_location"].apply(lambda x: x.longitude)
    df["coded_score"] = df["geo_location"].apply(lambda x: x.raw.get("score"))
    df.drop("geo_location", axis=1, inplace=True)
    return df


def dump_pharmacy_data(df: pd.DataFrame):
    df.to_csv("./data/geocoded_pharmacies.csv", index=False)
