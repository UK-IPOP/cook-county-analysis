from typing import Union
import asyncio
import csv
import json
from geopy.geocoders import ArcGIS
from geopy.adapters import AioHTTPAdapter
import geopy
import pandas as pd
from tqdm.asyncio import tqdm

# TODO: add type hints and docs


def process_results(result: geopy.Location, id_: int) -> dict[str, Union[float, None]]:
    return {
        "latitude": result.latitude if result.latitude else None,
        "longitude": result.longitude if result.longitude else None,
        "score": result.raw.get("score", None),
        "id": id_,
    }


def read_pharmacy_file():
    with open("./data/CookCounty_Pharmacies.csv", "r") as f:
        csvreader = csv.DictReader(f)
        return [
            f"{row['PharmacyAddress']} {row['City']} {row['State']} {row['Zip']}"
            for row in csvreader
        ]


async def geo_locate(geocoder, a: str, num: int):
    try:
        location = await geocoder.geocode(a)
        return location, num
    except geopy.exc.GeocoderTimedOut:
        await asyncio.sleep(1)
        return await geo_locate(geocoder, a, num)
    except geopy.exc.GeocoderServiceError:
        return await geo_locate(geocoder, a, num)


async def pharmacy_runner():
    addresses = read_pharmacy_file()
    async with ArcGIS(adapter_factory=AioHTTPAdapter, timeout=10.0) as geolocator:
        results = [
            await r
            for r in tqdm.as_completed(
                [geo_locate(geolocator, place, i) for i, place in enumerate(addresses)]
            )
        ]
    processed = [process_results(result, id_) for result, id_ in results]
    with open("./data/pharmacy_coded.json", "w") as f:
        json.dump(processed, f)


async def case_archive_runner(df):
    addresses = df.full_address.values
    async with ArcGIS(adapter_factory=AioHTTPAdapter, timeout=10.0) as geolocator:
        results = [
            await r
            for r in tqdm.as_completed(
                [geo_locate(geolocator, place, i) for i, place in enumerate(addresses)]
            )
        ]
    processed = [process_results(result, id_) for result, id_ in results]
    with open("./data/case_archives_coded.json", "w") as f:
        json.dump(processed, f)


def write_pharmacy_to_source():
    coded_df = pd.read_json("./data/pharmacy_coded.json")
    original_df = pd.read_csv("./data/CookCounty_Pharmacies.csv")
    coded_df.columns = ["coded_lat", "coded_long", "coded_score", "id"]
    new_df = original_df.join(coded_df.set_index("id"))
    new_df.to_csv("./data/geocoded_pharmacies.csv")


def write_case_archives_to_source(source_df: pd.DataFrame) -> pd.DataFrame:
    coded_df = pd.read_json("./data/case_archives_coded.json")
    coded_df.columns = ["coded_lat", "coded_long", "coded_score", "id"]
    new_df = source_df.join(coded_df.set_index("id"))
    return new_df
