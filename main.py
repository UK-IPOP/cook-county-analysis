from fastapi import FastAPI
from geopy.geocoders import ArcGIS
import typing


app = FastAPI()
geocoder = ArcGIS()


@app.get("/")
async def index():
    return "Welcome to this geocoding service."


@app.get("/geocode")
async def geocode(address: str) -> dict[str : typing.Union[str, int]]:
    """Route to geocode string addreses.

    Args:
        address (str): A full address string including street number, street name, city, state and zip

    Returns:
        dict(str): Dictionary mapping of latitude, longitude, altitude, and original address.
    """
    coded_info = geocoder.geocode(address)
    return {
        "latitude": coded_info.latitude,
        "longitude": coded_info.longitude,
        "altitude": coded_info.altitude,
        "address": coded_info.address,
    }
