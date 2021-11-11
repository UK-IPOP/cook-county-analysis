import pandas as pd

if __name__ == "__main__":
    drugs = pd.read_csv("./data/drugs/drugs_wide.csv", low_memory=False)
    records = pd.read_csv("./data/processed/clean_cases.csv", low_memory=False)
    df = pd.merge(
        records, drugs, left_on="casenumber", right_on="record_id", how="left"
    )
    print(df.shape)
    df.to_csv("./data/output/finalized.csv", index=False)
