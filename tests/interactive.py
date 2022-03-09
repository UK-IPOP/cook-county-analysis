# %%

import pandas as pd
import seaborn as sns
import plotly.express as px
import plotly.io as pio

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

drugs = pd.read_csv("../data/drugs/output.csv")
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
top_drugs = drugs[~drugs.drug_name.isin(["Alcohol", "Covid"])]
top_drugs.drug_name.value_counts().to_csv("drug_counts.csv")
# %%
df[(df.opiate_primary == 1) | (df.opiate_secondary == 1)].groupby("death_year").count()[
    "casenumber"
].to_csv("opioid_related_counts.csv")
# %%
df.groupby("death_year").count()["casenumber"].to_csv("total_cases_per_year.csv")
# %%
