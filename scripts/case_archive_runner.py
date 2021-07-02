from geocoding import case_archive_utils as cau

if __name__ == "__main__":
    print("Loading data...")
    df = cau.load_case_archive_data()
    print("Geocoding case archive data...")
    geocoded_df = cau.geocode_case_archive(df)
    print("Calculating distances...")
    distance_df = cau.calculate_distance(geocoded_df)
    print("Dumping data...")
    cau.dump_case_archive_data(distance_df)
    print('Done.')
