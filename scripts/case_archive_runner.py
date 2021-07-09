from pickle import TRUE
from geocoding import case_archive_utils as cau

# set this to `False` this if you have a specific file
# the file must be `Medical_Examiner_Case_Archive.csv`
# this may also cause some column naming conventions to break
LIVE = True

if __name__ == "__main__":
    print("Loading data...")
    df = cau.get_live_case_archive_data() if LIVE else cau.load_case_archive_data()
    print("Geocoding case archive data...")
    geocoded_df = cau.geocode_case_archive(df)
    print("Calculating distances...")
    distance_df = cau.calculate_distance(geocoded_df)
    print("Dumping data...")
    cau.dump_case_archive_data(distance_df)
    print("Done.")
