import pandas as pd


def extract_date_data(df: pd.DataFrame):
    df["death_date"] = df.death_date.apply(lambda x: pd.to_datetime(x))
    df["death_time"] = df.death_date.apply(lambda x: x.time() if pd.notna(x) else pd.NA)
    df["death_date"] = df.death_date.apply(lambda x: x.date())
    df["death_year"] = df.death_date.apply(lambda x: x.year)
    df["death_month"] = df.death_date.apply(lambda x: x.month)
    df["death_day"] = df.death_date.apply(lambda x: x.day)


if __name__ == "__main__":
    print("Starting final formatting.")
    df = pd.read_csv("./data/extracted_drugs.csv", low_memory=False)
    not_needed_cols = [
        "incident_street",
        "incident_city",
        "incident_zip",
        "longitude",
        "latitude",
        "location",
        "residence_city",
        "residence_zip",
        "objectid",
        ":@computed_region_tu5p_2ban",
        ":@computed_region_nqe2_pztc",
        ":@computed_region_h3ai_7k6i",
        "clean_address",
        "geometry",
        "index_right",
    ]
    df.drop(not_needed_cols, axis=1, inplace=True)
    extract_date_data(df)
    print("Data formatted, writing to csv")
    df.to_csv("./data/output.csv", index=False)
    print("Done.")
