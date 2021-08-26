import pandas as pd


def fill_nulls(df: pd.DataFrame):
    drug_cols = [
        col
        for col in df.columns
        if col.endswith("_primary") or col.endswith("_secondary")
    ]
    null_fillers = {c: False for c in drug_cols}
    df.fillna(null_fillers, inplace=True)


def extract_date_data(df: pd.DataFrame):
    df["death_date"] = df.date_of_death.apply(lambda x: pd.to_datetime(x))
    df["death_time"] = df.death_date.apply(lambda x: x.time() if pd.notna(x) else pd.NA)
    df["death_date"] = df.death_date.apply(lambda x: x.date())
    df["death_year"] = df.death_date.apply(lambda x: x.year)
    df["death_month"] = df.death_date.apply(lambda x: x.month)
    df["death_day"] = df.death_date.apply(lambda x: x.day)


if __name__ == "__main__":
    print("Starting final formatting.")
    df = pd.read_csv("./data/extracted_drugs.csv", low_memory=False)
    not_needed_cols = [
        "incident_address",
        "incident_city",
        "incident_zip_code",
        "longitude",
        "latitude",
        "location",
        "objectid",
        "clean_address",
        "geometry",
    ]
    df.drop(not_needed_cols, axis=1, inplace=True)
    extract_date_data(df)
    fill_nulls(df)
    print("Data formatted, writing to csv")
    df.to_csv("./data/output.csv", index=False)
    print("Done.")
