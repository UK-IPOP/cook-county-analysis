import pandas as pd

if __name__ == "__main__":
    print("Loading files...")
    df1 = pd.read_csv("./data/joined_records.csv", low_memory=False)
    df2 = pd.read_csv("./data/drug_classifications.csv", low_memory=False)
    print("Merging datasets...")
    df3 = pd.merge(df1, df2, left_on="casenumber", right_on="primary_id")
    print("Dumping datafiles...")
    df3.to_csv("./data/output.csv", index=False)
    print("Done.")
