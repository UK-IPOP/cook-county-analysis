import pandas as pd


if __name__ == "__main__":
    primary = pd.read_csv("../data/drugs/primary_drugs.csv")
    primary["level"] = "primary"
    secondary = pd.read_csv("../data/drugs/secondary_drugs.csv")
    secondary["level"] = "secondary"
    drugs = pd.concat([primary, secondary])
    drugs.to_csv("../data/drugs/combined_drugs.csv", index=False)
