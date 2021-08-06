import pandas as pd

if __name__ == "__main__":
    print("Starting final formatting.")
    df = pd.read_csv("./data/extracted_drugs.csv", low_memory=False)
    not_needed_cols = [
        "incident_street",
        "incident_city",
        "incident_zip",
        "longitude",
        "latitude",
        "location",
        "residence_city",
        "residence_zip",
        "objectid",
        ":@computed_region_tu5p_2ban",
        ":@computed_region_nqe2_pztc",
        ":@computed_region_h3ai_7k6i",
        "clean_address",
        "geometry",
        "index_right",
    ]
    df.drop(not_needed_cols, axis=1, inplace=True)
    print("Data formatted, writing to csv")
    df.to_csv("./data/output.csv", index=False)
    print("Done.")
