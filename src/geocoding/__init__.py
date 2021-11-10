from . import fetch_data, geocode
from rich import print, pretty

pretty.install()


def main():
    print("Fetching data...")
    fetch_data.main()
    print("Geocoding data...")
    geocode.initialize()
    geocode.main()
