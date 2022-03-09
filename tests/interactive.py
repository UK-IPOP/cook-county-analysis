# %%

from collections import defaultdict
import pandas as pd
import seaborn as sns
import plotly.express as px
import plotly.io as pio
import numpy as np
from collections import defaultdict

pio.renderers.default = "notebook"
# %%

df = pd.read_csv("../data/output/finalized.csv", low_memory=False)

[c for c in df.columns if not c.endswith("_primary") and not c.endswith("_secondary")]

# %%

df.recovered.sum()

# %%
df.shape
# %%

len([c for c in df.columns if c.endswith("_primary") or c.endswith("_secondary")])

# %%
print(df.closest_pharmacy.describe())
# %%

drugs = pd.read_csv("../data/drugs/combined_drugs.csv")
drugs.head()

# %%
drugs.similarity_ratio.describe()
# %%

drugs.drug_name.value_counts()

# %%
drugs[drugs.drug_name == "Cocaine"].word_found.value_counts()
# %%
geo = pd.read_csv("../data/processed/cases_with_distances.csv")
geo.head()
# %%
geo.closest_pharmacy.describe()

# %%
drug_counts = (
    drugs.groupby("drug_name").count().sort_values("record_id", ascending=False)
)
drug_counts[:15]["record_id"].to_csv("drug_counts.csv")

# %%
df.groupby("death_year").count()["casenumber"].to_csv("total_cases_per_year.csv")
# %%
drugs[drugs.drug_name.isin(("Alcohol", "Cocaine", "Fentanyl-Name", "Heroin"))].groupby(
    ["drug_name", "word_found"]
).agg(["mean", "count"])

# %%
