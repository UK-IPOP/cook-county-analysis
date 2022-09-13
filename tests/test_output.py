import pandas as pd
import numpy as np
import csv
import pytest


@pytest.fixture
def df() -> pd.DataFrame:
    """Loads output dataframe."""
    return pd.read_csv("../data/output/finalized.csv", low_memory=False)


@pytest.fixture
def landuse_dict() -> list[dict[str, str]]:
    data = []
    with open("../data/raw/landuse_data_dictionary.csv", "r") as f:
        csvreader = csv.DictReader(f)
        for line in csvreader:
            data.append(line)
    return data


def test_output_df_columns(df: pd.DataFrame):
    assert "casenumber" in df.columns


def test_drug_output(df: pd.DataFrame):
    drug_cols = [
        x for x in df.columns if x.endswith("_primary") or x.endswith("_secondary")
    ]
    drugs = df.loc[:, drug_cols]
    assert all(x in {0, 1, 9} for x in drugs.values.flatten())


def test_casenumber(df: pd.DataFrame):
    assert df.casenumber.is_unique


def test_age(df: pd.DataFrame):
    assert df.age.min() >= 0


def test_gender(df: pd.DataFrame):
    assert all(x in {"Male", "Female", "Unknown", np.nan} for x in df.gender.unique())
    counts = df.gender.value_counts()
    assert counts["Male"] > counts["Unknown"]
    assert counts["Female"] > counts["Unknown"]


def test_race(df: pd.DataFrame):
    assert all(
        x
        in {
            "Am. Indian",
            "Asian",
            "Black",
            "Other",
            "Unknown",
            "White",
            np.nan,
        }
        for x in df.race.unique()
    )


def test_latino(df: pd.DataFrame):
    assert set(df.latino.unique()) == {0, 1}


def test_hot_cold(df: pd.DataFrame):
    unique = set()
    for x in df.cold_related.unique():
        unique.add(x)
    for x in df.heat_related.unique():
        unique.add(x)
    assert unique == {0, 1}


def test_comm_district(df: pd.DataFrame):
    assert df.commissioner_district.max() == 17.0
    assert df.commissioner_district.min() > 0


def test_residence_city(df: pd.DataFrame):
    counts = df.residence_city.value_counts().to_dict()
    assert all(x <= counts["Chicago"] for x in counts.values())


def test_manner(df: pd.DataFrame):
    assert set(df.manner.unique()) == {
        "ACCIDENT",
        "HOMICIDE",
        "NATURAL",
        "PENDING",
        "SUICIDE",
        "UNDETERMINED",
        np.nan,
    }


def test_gun_related(df: pd.DataFrame):
    # convoluted but removes annoying np.nan issue
    for k in df.gunrelated.value_counts().to_dict().keys():
        assert k in {0.0, 1.0}


def test_opioids(df: pd.DataFrame):
    for k in df.opioids.value_counts().to_dict().keys():
        assert k in {0.0, 1.0}


def test_geocoded_score(df: pd.DataFrame):
    info = df.geocoded_score.describe()
    assert info["min"] >= 70
    assert info["max"] <= 100


def test_recovered(df: pd.DataFrame):
    assert set(df.recovered.unique()) == {0.0, 1.0}


def test_final_lat(df: pd.DataFrame):
    info = df.final_latitude.describe()
    assert info["min"] > 36.0
    assert info["max"] < 43.0


def test_final_long(df: pd.DataFrame):
    info = df.final_longitude.describe()
    assert info["min"] > -92.0
    assert info["max"] < -87.0


def test_closest_pharmacy():
    # TODO: fix after algorithm correction
    assert 12 < 10


def test_landuse_id(df: pd.DataFrame):
    info = df.LANDUSE.describe()
    assert info["min"] > 1_000
    assert info["max"] < 10_000


def test_landuse_name(landuse_dict: list[dict[str, str]], df: pd.DataFrame):
    names = set()
    for line in landuse_dict:
        names.add(line["name"])

    table = set(df.landuse_name.unique())
    for item in table:
        if pd.isna(item):
            continue
        assert item in names


def test_landuse_subname(landuse_dict: list[dict[str, str]], df: pd.DataFrame):
    names = set()
    for line in landuse_dict:
        names.add(line["sub_name"])

    table = set(df.landuse_sub_name.unique())
    for item in table:
        if pd.isna(item):
            continue
        assert item in names


def test_landuse_major_name(landuse_dict: list[dict[str, str]], df: pd.DataFrame):
    names = set()
    for line in landuse_dict:
        names.add(line["major_name"])

    table = set(df.landuse_major_name.unique())
    for item in table:
        if pd.isna(item):
            continue
        assert item in names
