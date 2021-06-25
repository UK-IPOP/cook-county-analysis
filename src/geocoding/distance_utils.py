from operator import index
from typing import Union
from geopy import distance
import pandas as pd
from tqdm import tqdm

tqdm.pandas()


def get_pharmacy_points() -> list[tuple[float, float]]:
    points = []
    pharmacies = pd.read_csv("./data/geocoded_pharmacies.csv")
    for _, pharm in pharmacies.iterrows():
        if pd.notna(pharm.coded_lat) and pd.notna(pharm.coded_long):
            point = (pharm.coded_lat, pharm.coded_long)
            points.append(point)
    return points


def calculate_distance(
    row: pd.Series, pharm_points: list[tuple[float, float]]
) -> Union[float, None]:
    distances = []
    if pd.isna(row.coded_lat) or pd.isna(row.coded_long):
        return None
    for p in pharm_points:
        d = distance.distance(
            (row.coded_lat, row.coded_long),  # case archive (point1)
            (p[0], p[1]),  # pharmacy (point2)
        )
        # miles
        distances.append(d.mi)
    return min(distances)


def apply_distance():
    case_archives = pd.read_csv("./data/geocoded_case_archives.csv", low_memory=False)
    pharm_point_list = get_pharmacy_points()
    case_archives["nearest_pharmacy"] = case_archives.progress_apply(
        lambda row: calculate_distance(row, pharm_point_list), axis=1
    )
    case_archives.to_csv("./data/case_archives_distances.csv", index=False)
