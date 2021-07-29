from ssl import SSLSocket
from geocoding import case_archive_utils as cau
from geocoding import async_utils as au
import asyncio
from geocoding.config import FAST
import pandas as pd
from tqdm import trange

# set this to `False` this if you have a specific file
# the file must be `Medical_Examiner_Case_Archive.csv`
# this may also cause some column naming conventions to break
# LIVE = True


if __name__ == "__main__":
    if FAST:
        print("Starting case archive runner...")
        print("Loading data...")
        ssdf = cau.get_live_case_archive_data()
        # loaded = pd.read_csv(
        #     "./data/extracted_case_archives.csv", low_memory=False
        # )  # will comment this out later in favor of live feed
        print(
            f"Geocoding case archive data... there are {int(len(loaded) / 500)} bunches..."
        )
        for bunch in trange(0, len(loaded) - 500, 500):
            asyncio.run(au.case_archive_runner(loaded.loc[bunch : bunch + 500]))
        geocoded_df = au.write_case_archives_to_source(loaded)
        print("Calculating distances...")
        distance_df = cau.calculate_distance(geocoded_df)
        print("Dumping data...")
        cau.dump_case_archive_data(distance_df)
        print("Done.")
    else:
        print("Starting case archive runner...")
        print("Loading data...")
        df = cau.get_live_case_archive_data()
        print("Geocoding case archive data...")
        geocoded_df = cau.geocode_case_archive(df)
        print("Calculating distances...")
        distance_df = cau.calculate_distance(geocoded_df)
        print("Dumping data...")
        cau.dump_case_archive_data(distance_df)
        print("Done.")
