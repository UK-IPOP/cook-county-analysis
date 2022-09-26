# %%
import pandas as pd
from pathlib import Path

# %%
analytic_path = Path("./secure/old/analytical.csv")
df = pd.read_csv(analytic_path, low_memory=False)
df.head()

# %%
df["death_date"] = pd.to_datetime(df["death_date"])
total_records = df.shape[0]
df = df[df["death_date"] < pd.to_datetime("07-01-2022")]
print(f"{total_records - df.shape[0]} records removed")

# %%
def label(row) -> str:
    if row["fentanyl_primary"] == 1 or row["fentanyl_secondary"] == 1:
        # fentanyl related
        if row["xylazine_primary"] == 1 or row["xylazine_secondary"] == 1:
            # xylazine case
            return "xylazine"
        else:
            # fentanyl control
            return "fentanyl"
    elif (row["eth_alc_primary"] == 1 or row["eth_alc_secondary"] == 1) and (
        row["opiate_primary"] != 1 or row["opiate_secondary"] != 1
    ):
        # alcohol control
        return "alcohol"
    else:
        return "other"


# %%
df["group"] = df.apply(lambda row: label(row), axis=1)
no_other = df[df["group"] != "other"].copy()
no_other.groupby("group").size()

# %%
no_other.shape

# %%
no_other.to_csv("combined.csv", index=False)

# %%
