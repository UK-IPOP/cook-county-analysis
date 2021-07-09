from geocoding import pharmacy_utils as pu

if __name__ == "__main__":
    print("Loading data...")
    df = pu.load_pharmacy_data()
    print("Geocoding pharmacy addresses...")
    geocoded_df = pu.geocode_pharmacy(df)
    print("Dumping data...")
    pu.dump_pharmacy_data(geocoded_df)
    print("Done.")
