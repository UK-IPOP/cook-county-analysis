from operator import index
from geopy import distance
import pandas as pd

from . import case_archive_utils as cau, pharmacy_utils as pu

def calculate_distance(row: pd.Series, pharm_df: pd.DataFrame) -> float:
    distances = []
    for _, pharm in pharm_df.iterrows():
        d = distance.distance(
            (row.coded_lat, row.coded_long),  # case archive (point1)
            (pharm.coded_lat, pharm.coded_long),  # pharmacy (point2)
        )
        # miles 
        distances.append(d.mi)
    return min(distances)

def apply_distance():
    pharmacies = pu.load_pharmacy_data()
    case_archives = cau.load_case_archive_data()
    case_archives['distance'] = case_archives.apply(
        lambda row: calculate_distance(row, pharm_df=pharmacies), axis=1
    )
    case_archives.to_csv('./data/case_archives_distances.csv', index=False)