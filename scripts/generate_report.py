import pandas as pd
import pandas_profiling as pp
import json
import datetime

today = datetime.datetime.today().strftime("%Y-%m-%d")

with open("data/field_descriptions.json", "r") as f:
    definitions = json.load(f)

df = pd.read_csv("data/output/finalized.csv", low_memory=False)
profile = df.profile_report(
    title="Output dataset",
    variables={"descriptions": definitions},
)

profile.to_file(f"reports/report_{today}.html")

print("Done!")
