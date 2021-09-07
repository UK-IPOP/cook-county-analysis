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
    df["death_datetime"] = df.date_of_death.apply(lambda x: pd.to_datetime(x))
    df["death_time"] = df.death_datetime.apply(
        lambda x: x.time() if pd.notna(x) else pd.NA
    )
    df["death_date"] = df.death_datetime.apply(lambda x: x.date())
    df["death_year"] = df.death_date.apply(lambda x: x.year)
    df["death_month"] = df.death_date.apply(lambda x: x.month)
    df["death_day"] = df.death_date.apply(lambda x: x.day)
    df["death_week"] = df.death_datetime.dt.isocalendar().week


def resolve_room(x: str) -> bool:
    if "room" in x.lower():
        # find index for word
        words = x.lower().split()
        index = next((i for i, word in enumerate(words) if word == "room"), None)
        if index:
            if words[index + 1][0].isnumeric():
                return True
    return False


def classify_hotels(x: str) -> bool:
    if pd.isna(x):
        return None
    hotel_words = {"hotel", "motel", "holiday inn", "travel lodge"}
    if any(word in x.lower() for word in hotel_words):
        return True
    if resolve_room(x):
        return True
    return False


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
    df["motel"] = df.full_address.apply(lambda x: classify_hotels(x))
    fill_nulls(df)
    print("Data formatted, writing to csv")
    df.to_csv("./data/output.csv", index=False)
    print("Done.")
