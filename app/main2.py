import codecs
import csv
import time
from fastapi import FastAPI
from fastapi.responses import StreamingResponse, FileResponse
from fastapi import FastAPI, File, UploadFile

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


def stream_geocoding():
    geocoder = ArcGIS()
    for _ in range(20):
        data = geocoder.geocode("2419 ashbury circle cape coral fl")
        yield f"lat: {data.latitude}; long: {data.longitude}"


some_file_path = "requirements.txt"


@app.get("/streamer")
async def streamer():
    return FileResponse(some_file_path, filename="requirements.txt", media_type="text")
    # return StreamingResponse(stream_geocoding())


@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    geocoder = ArcGIS()
    valuables = []
    csv_reader = csv.DictReader(codecs.iterdecode(file.file, "utf-8"))
    for row in csv_reader:
        if csv_reader.line_num > 10:
            break
        address = f"{row['PharmacyAddress']} {row['City']} {row['State']} {row['Zip']}"
        data = geocoder.geocode(address)
        result = {
            "address": data.address,
            "latitude": data.latitude,
            "longitude": data.longitude,
            "score": data.raw.get("score"),
        }
        valuables.append(result)
    keys = valuables[0].keys()
    with open("records.csv", "w", newline="") as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(valuables)
    return FileResponse("records.csv")
