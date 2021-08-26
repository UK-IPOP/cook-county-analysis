from geocoding import drug_extract_utils as de
from tqdm import tqdm


if __name__ == "__main__":
    print("Starting drug extraction.")
    df = de.load_data()
    df = de.make_combined_secondary(df)
    dff = df.copy(deep=True)
    print("Extracting drugs...")
    drugs = de.DRUG_CLASS.load_from_file("./data/drug_dictionary.csv")
    print("Analyzing...")

    # have to loop this
    for drug in tqdm(drugs):
        dff[f"{drug.name.lower()}_primary"] = dff.primarycause.apply(
            lambda x: de.search_handler(x, search_words=drug.search_terms)
        )
        dff[f"{drug.name.lower()}_secondary"] = dff.secondary_combined.apply(
            lambda x: de.search_handler(x, search_words=drug.search_terms)
        )

    # TODO: make a function to do this
    for i, row in tqdm(dff.iterrows(), total=dff.shape[0]):
        for drug in drugs:
            categories = {
                k: v
                for k, v in drug.__dict__.items()
                if v and k != "search_terms" and k != "name"
            }
            for key in categories.keys():
                if row[f"{drug.name.lower()}_primary"]:
                    dff.loc[i, f"{key.lower()}_primary"] = categories[key]
                if row[f"{drug.name.lower()}_secondary"]:
                    dff.loc[i, f"{key.lower()}_secondary"] = categories[key]

    print("Dumping file...")
    # dff.to_csv("./data/new_drugs.csv", index=False)
    de.write_file(dff)
    print("Done.")
