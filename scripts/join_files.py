import pandas as pd


def fill_nulls(table: pd.DataFrame):
    """Fills nulls in columns that end with `_primary` or `_secondary` with `9`."""
    drug_cols = [
        col
        for col in table.columns
        if col.endswith("_primary") or col.endswith("_secondary")
    ]
    null_fillers = {c: 9 for c in drug_cols}
    new_table = table.fillna(null_fillers)
    return new_table


if __name__ == "__main__":
    drugs = pd.read_csv("./data/drugs/drugs_wide.csv", low_memory=False)
    records = pd.read_csv("./data/processed/clean_cases.csv", low_memory=False)
    df = pd.merge(
        records, drugs, left_on="casenumber", right_on="record_id", how="left"
    )
    print(df.shape)

    df = fill_nulls(df)
    df.drop(columns=["record_id"], axis=1, inplace=True)
    df.to_csv("./data/output/finalized.csv", index=False)
