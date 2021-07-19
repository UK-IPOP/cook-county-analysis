from geocoding import pharmacy_utils as pu
from geocoding import async_utils as au
import asyncio
from geocoding.config import FAST

if __name__ == "__main__":
    if FAST:
        print("Starting pharmacy runner...")
        print("Geocoding pharmacy addresses...")
        asyncio.run(au.pharmacy_runner())
        print("Dumping data...")
        au.write_pharmacy_to_source()
        print("Done.")
    else:
        print("Starting pharmacy runner...")
        print("Loading data...")
        df = pu.load_pharmacy_data()
        print("Geocoding pharmacy addresses...")
        geocoded_df = pu.geocode_pharmacy(df)
        print("Dumping data...")
        pu.dump_pharmacy_data(geocoded_df)
        print("Done.")
