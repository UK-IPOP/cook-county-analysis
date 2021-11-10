from __future__ import annotations
import pandas as pd


def load_cases() -> pd.DataFrame:
    return pd.read_csv("data/processed/cases_with_distances.csv", low_memory=False)


def preprocess(df: pd.DataFrame) -> pd.DataFrame:
    extract_date_data(df)
    df["motel"] = df.full_address.apply(lambda x: classify_hotels(x))
    df["hot_combined"] = df.apply(lambda row: make_hot_cold(row, "hot"), axis=1)
    df["cold_combined"] = df.apply(lambda row: make_hot_cold(row, "cold"), axis=1)

    # make primary cause col combined
    df["primary_combined"] = df.apply(lambda row: join_cols(row), axis=1)

    # remove unwanted cols
    not_needed_cols = [
        "incident_street",
        "incident_city",
        "incident_zip",
        "location",
        "objectid",
        "clean_address",
        ":@computed_region_tu5p_2ban",
        ":@computed_region_nqe2_pztc",
        ":@computed_region_h3ai_7k6i",
        "chi_ward",
        "chi_commarea",
    ]
    df.drop(not_needed_cols, axis=1, inplace=True)

    df = clean_data(df)
    return df


def join_cols(row) -> str:
    """Joins various column values."""
    return f"{row['primarycause'] if pd.notna(row['primarycause']) else ''}{row['primarycause_linea'] if pd.notna(row['primarycause_linea']) else ''}{row['primarycause_lineb'] if pd.notna(row['primarycause_lineb']) else ''}{row['primarycause_linec'] if pd.notna(row['primarycause_linec']) else ''}"


def fill_nulls(df: pd.DataFrame):
    drug_cols = [
        col
        for col in df.columns
        if col.endswith("_primary") or col.endswith("_secondary")
    ]
    null_fillers = {c: 9 for c in drug_cols}
    df = df.fillna(null_fillers)
    return df


def extract_date_data(df: pd.DataFrame):
    df["death_datetime"] = df.death_date.apply(lambda x: pd.to_datetime(x))
    df["death_time"] = df.death_datetime.apply(
        lambda x: x.time() if pd.notna(x) else pd.NA
    )
    df["death_date"] = df.death_datetime.apply(lambda x: x.date())
    df["death_year"] = df.death_date.apply(lambda x: x.year)
    df["death_month"] = df.death_date.apply(lambda x: x.month)
    df["death_day"] = df.death_date.apply(lambda x: x.day)
    df["death_week"] = df.death_datetime.dt.isocalendar().week
    df.drop("death_date", axis=1, inplace=True)


def resolve_room(x: str) -> bool:
    if "room" in x.lower():
        # find index for word
        words = x.lower().split()
        index = next((i for i, word in enumerate(words) if word == "room"), None)
        if index and words[index + 1][0].isnumeric():
            return True
    return False


def classify_hotels(x: str) -> bool | None:
    if pd.isna(x):
        return None
    hotel_words = {"hotel", "motel", "holiday inn", "travel lodge"}
    if any(word in x.lower() for word in hotel_words):
        return True
    if resolve_room(x):
        return True
    return False


def make_hot_cold(row: pd.Series, x: str) -> bool:
    if x == "hot":
        hot = row["heat_related"] if pd.notna(row["heat_related"]) else False
        secondary = row["secondarycause"] if pd.notna(row["secondarycause"]) else ""
        if "hot" in secondary.lower() or hot:
            return True
        return False
    elif x == "cold":
        cold = row["cold_related"] if pd.notna(row["cold_related"]) else False
        secondary = row["secondarycause"] if pd.notna(row["secondarycause"]) else ""
        if "cold" in secondary.lower() or cold:
            return True
        return False
    else:
        raise ValueError(f"{x} not valid value for hot/cold")


def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    df = fill_nulls(df)
    df = df.replace(to_replace={True: 1, False: 0})
    df = df.drop_duplicates(subset=["casenumber"])
    return df


def main():
    df = load_cases()
    df = preprocess(df)
    df.to_csv("data/processed/clean_cases.csv", index=False)


if __name__ == "__main__":
    main()