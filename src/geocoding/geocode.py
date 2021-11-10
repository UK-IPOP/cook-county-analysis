from __future__ import annotations

import os

import dotenv
import pandas as pd
from arcgis.geocoding import geocode
from arcgis.gis import GIS
from rich.progress import track
import re


def initialize():
    dotenv.load_dotenv()
    GIS(
        api_key=os.getenv("ARCGIS_API_KEY"),
    )


def load_case_file() -> pd.DataFrame:
    df = pd.read_csv("data/raw/cases.csv", low_memory=False)
    return df


def prepare_df(df: pd.DataFrame) -> pd.DataFrame:
    # drop where incident_street is None
    df = df[df["incident_street"].notna()]
    # regex removal
    df["clean_address"] = df.apply(clean_address, axis=1)
    df = df[df["clean_address"].notna()]
    # subs city if needed and combines address fields
    addresses = df.apply(lambda row: create_address(row), axis=1)
    df["full_address"] = [a[0] for a in addresses]
    df["city_subbed"] = [a[1] for a in addresses]
    return df


def run_geocoding(addresses: list[str]) -> list[dict[str, str | float]]:
    results = []
    for address in track(addresses, description="Geocoding..."):
        geocoded_info = geocode(address)
        if geocoded_info:
            best_result = geocoded_info[0]
            geo_data = {
                "address": best_result["address"],
                "latitude": best_result["location"]["y"],
                "longitude": best_result["location"]["x"],
                "score": best_result["score"],
            }
            results.append(geo_data)
        else:
            results.append(
                {"address": address, "latitude": None, "longitude": None, "score": None}
            )
    return results


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


def clean_address(row: pd.Series) -> int | str | None:
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
    return no_apartment_info


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


def main():
    cases = load_case_file()
    # cases = cases[:500]

    # preprocess
    cases = prepare_df(cases)
    geocoding_results = run_geocoding(cases.full_address.values)
    # assign results to dataframe
    cases["geocoded_latitude"] = [x["latitude"] for x in geocoding_results]
    cases["geocoded_longitude"] = [x["longitude"] for x in geocoding_results]
    cases["geocoded_score"] = [x["score"] for x in geocoding_results]
    cases["geocoded_address"] = [x["address"] for x in geocoding_results]
    # save results
    cases.to_csv("data/processed/geocoded_cases.csv", index=False)


if __name__ == "__main__":
    initialize()
    main()
