from geocoding import drug_extract_utils as de
from tqdm import tqdm

if __name__ == "__main__":
    print("Starting drug extraction.")
    df = de.load_data()
    dff = de.make_combined_secondary(df)
    print("Extracting drugs...")
    # have to loop this
    for key, value in tqdm(
        de.DRUG_CLASSIFICATIONS.items(), total=len(de.DRUG_CLASSIFICATIONS)
    ):
        dff[f"{key}_primary"] = df.primarycause.apply(
            lambda x: de.search_handler(x, search_words=value)
        )
        dff[f"{key}_secondary"] = df.secondary_combined.apply(
            lambda x: de.search_handler(x, search_words=value)
        )
    de.make_composite_fentanyl(df=dff)
    de.find_drug_related(df=dff)
    print("Analyzing...")
    de.write_file(dff)
    print("Done.")
