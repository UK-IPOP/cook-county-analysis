import pandas as pd
import numpy as np


def fill_nulls(df: pd.DataFrame):
    drug_cols = [
        col
        for col in df.columns
        if col.endswith("_primary") or col.endswith("_secondary")
    ]
    null_fillers = {c: 9 for c in drug_cols}
    df = df.fillna(null_fillers)
    return df


if __name__ == "__main__":
    drugs = pd.read_csv("./data/drugs/drugs_wide.csv", low_memory=False)
    records = pd.read_csv("./data/processed/clean_cases.csv", low_memory=False)
    df = pd.merge(
        records, drugs, left_on="casenumber", right_on="record_id", how="left"
    )
    print(df.shape)

    df = fill_nulls(df)
    df.to_csv("./data/output/finalized.csv", index=False)
