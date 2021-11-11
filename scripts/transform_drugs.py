import pandas as pd
import numpy as np
from collections import defaultdict

if __name__ == "__main__":
    primary = pd.read_csv("./data/drugs/primary_drugs.csv")
    primary["level"] = "primary"
    secondary = pd.read_csv("./data/drugs/secondary_drugs.csv")
    secondary["level"] = "secondary"
    drugs = pd.concat([primary, secondary])
    drugs.to_csv("./data/drugs/combined_drugs.csv", index=False)

    data = defaultdict(dict)
    for item in drugs.to_dict("records"):
        tags = item["tags"].split(";")
        data[item["record_id"]][f"{item['drug_name'].lower()}_{item['level']}"] = 1
        for tag in tags:
            data[item["record_id"]][f"{tag}_{item['level']}"] = 1
    for d in data:
        data[d]["record_id"] = d
    drugs_wide = pd.DataFrame([data[d] for d in data])
    drugs_wide.replace(to_replace=np.NaN, value=0, inplace=True)
    drugs_wide.to_csv("./data/drugs/drugs_wide.csv", index=False)
