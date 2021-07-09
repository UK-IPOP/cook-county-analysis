from operator import index
from typing import Union

import pandas as pd
from geopy import distance
from tqdm import tqdm

tqdm.pandas()


def get_pharmacy_points() -> list[tuple[float, float]]:
    """Gets lat/long points from geocoded pharmacy file.

    Returns:
        list[tuple[float, float]]: list of (lat, long)
    """
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
    """Calculates the minimum distance between each row and the points.

    This function calculates the distance from the row's lat/long to all of
    the pharm_points in miles and then returns the minimum distance for each
    row.

    Args:
        row (pd.Series): row of the dataframe
        pharm_points (list[tuple[float, float]]): list of lat/long points

    Returns:
        Union[float, None]: Distance in miles or None if no lat/long provided in the row.
    """
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
    """Utility function to apply the distance calculation and save the resulting file."""
    case_archives = pd.read_csv("./data/geocoded_case_archives.csv", low_memory=False)
    pharm_point_list = get_pharmacy_points()
    case_archives["nearest_pharmacy"] = case_archives.progress_apply(
        lambda row: calculate_distance(row, pharm_point_list), axis=1
    )
    case_archives.to_csv("./data/case_archives_distances.csv", index=False)
