# run from xylazine_analysis folder

# %%
import pandas as pd
from pathlib import Path

# %%
# analytic_path = Path("./secure/old/analytical.csv")
analytic_path = Path("../../data/records_with_spatial_data.csv")
df = pd.read_csv(analytic_path, low_memory=False)
print(f"Number of records: {len(df)}")
df.head()

# %%
df["death_date"] = pd.to_datetime(df["death_date"])
total_records = df.shape[0]
df = df[
    (df["death_date"] < pd.to_datetime("07-01-2022"))
    & (df["death_date"] >= pd.to_datetime("01-01-2019"))
].copy()
print(f"{total_records - df.shape[0]} records removed due to date filter")
total_records = df.shape[0]
# not in cook county
df = df[df["COUNTYFP_right"].notna()].copy()
print(f"{total_records - df.shape[0]} records removed due to not in cook county filter")

# %%
def label(row) -> str:
    if row["fentanyl_1"] == 1 or row["fentanyl_2"] == 1:
        # fentanyl related
        if row["xylazine_1"] == 1 or row["xylazine_2"] == 1:
            # xylazine case
            return "xylazine"
        else:
            # fentanyl control
            return "fentanyl"
    elif (
        row["eth_alc_tag"] == 1
        and row["xylazine_1"] != 1
        and row["xylazine_2"] != 1
        and row["fentanyl_1"] != 1
        and row["fentanyl_2"] != 1
    ):
        # alcohol control
        return "alcohol"
    elif (
        row["stimulant_tag"] == 1
        and row["xylazine_1"] != 1
        and row["xylazine_2"] != 1
        and row["fentanyl_1"] != 1
        and row["fentanyl_2"] != 1
    ):
        # stimulant control
        return "stimulant"
    else:
        return "other"


# %%
df["group"] = df.apply(lambda row: label(row), axis=1)
no_other = df[df["group"] != "other"].copy()
print(no_other.groupby("group").size())

# %%
print(no_other.shape)

# %%
outpath = "combined.csv"
no_other.to_csv(outpath, index=False)

# %%
