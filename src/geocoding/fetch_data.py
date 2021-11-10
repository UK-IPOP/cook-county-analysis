import pandas as pd
from sodapy import Socrata


def get_live_me_data() -> pd.DataFrame:
    client = Socrata("datacatalog.cookcountyil.gov", None)
    results = client.get("cjeq-bs86", limit=100_000)  # id for case archives dataset
    results_df = pd.DataFrame.from_records(results)
    return results_df


def main():
    cases = get_live_me_data()
    cases.to_csv("data/raw/cases.csv", index=False)
