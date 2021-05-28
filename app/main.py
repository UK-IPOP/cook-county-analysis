from fastapi import FastAPI
from geopy.geocoders import ArcGIS
import typing

app = FastAPI()


@app.get("/")
async def index() -> str:
    """Returns welcome message

    Returns:
        str: Welcome to this geocoding service.
    """
    text = "Welcome to this geocoding service. Please use the /geocode route to query your address."
    return text


@app.get("/geocode")
async def geocode(address: str) -> typing.Dict[str, typing.Union[str, float]]:
    """Route to geocode string addresses.

    Args:
        address (str): A full address string including street number, street name, city, state and zip

    Returns:
        dict(str): Dictionary mapping of latitude, longitude, altitude, the original address, and an accuracy score.
    """
    geocoder = ArcGIS()
    coded_info = geocoder.geocode(address)
    return {
        "address": coded_info.address,
        "altitude": coded_info.altitude,
        "latitude": coded_info.latitude,
        "longitude": coded_info.longitude,
        "score": coded_info.raw.get("score"),
    }
