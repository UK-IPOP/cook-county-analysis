# %%

import pandas as pd
from rich import pretty
from sodapy import Socrata

pretty.install()
# %%

df = pd.read_csv("../data/output/finalized.csv", low_memory=False)

[c for c in df.columns if not c.endswith("_primary") and not c.endswith("_secondary")]

# %%

# client = Socrata("datacatalog.cookcountyil.gov", None)
# results = client.get("8f9d-wy2d", limit=1_000_000)  # id for case archives dataset
# results_df = pd.DataFrame.from_records(results)

# results_df.head()
# %%

prices = pd.read_csv("../data/raw/housing_prices.csv", low_memory=False)

# %%

ours = [(r.final_latitude, r.final_longitude) for r in df.itertuples()]
theirs = [(round(r.Latitude, 8), round(r.Longitude, 8)) for r in prices.itertuples()]

# %%

any(x in theirs for x in ours)

# %%

theirs[0]

# %%
ours[0]

# %%
