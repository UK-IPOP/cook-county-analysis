import pandas as pd
import pytest


@pytest.fixture
def output_df():
    return pd.read_csv("data/output/finalized.csv", low_memory=False)


def test_output_df_columns(output_df):
    assert "casenumber" in output_df.columns


def test_drug_output(output_df):
    drug_cols = [
        x
        for x in output_df.columns
        if x.endswith("_primary") or x.endswith("_secondary")
    ]
    drugs = output_df.loc[:, drug_cols]
    assert all(x in {0, 1, 9} for x in drugs.values.flatten())
