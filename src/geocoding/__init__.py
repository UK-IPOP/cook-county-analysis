from rich import pretty, print

from . import fetch_data, geocode

pretty.install()


def main():
    print("Fetching data...")
    fetch_data.main()
    print("Geocoding data...")
    geocode.initialize()
    geocode.main()
