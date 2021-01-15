from fastapi import FastAPI, File, UploadFile
from fastapi.responses import FileResponse, HTMLResponse
from geopy.geocoders import ArcGIS
import pandas as pd
import typing
import csv

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


@app.post("/uploadcsv/")
async def upload_csv(csv_file: UploadFile = File(...)) -> FileResponse:
    """Takes an uploaded csv file and geocodes the address column into three (lat, long, alt) columns.
    Will Error if file is not 1 column containing only address data (no headers)

    Args:
        csv_file (UploadFile, optional): [description]. Defaults to File(...).

    Raises:
        ValueError: If column address not found

    Returns:
        FileResponse: new file
    """
    contents = await csv_file.read()
    data = contents.decode("utf-8").splitlines()
    df = pd.DataFrame(data, columns=["address"])
    if "address" not in df.columns:
        raise ValueError(f"Excepted column named `address`")
    # intialize as empty
    df["latitude"] = ""
    df["longitude"] = ""
    df["altitude"] = ""
    for i, row in df.iterrows():
        coded_info = geocoder.geocode(row.address)
        print(coded_info)
        df.loc[i, "latitude"] = coded_info.latitude
        df.loc[i, "longitude"] = coded_info.longitude
        df.loc[i, "altitude"] = coded_info.altitude
    df.to_csv("coded_addresses.csv", index=False)
    return FileResponse("coded_addresses.csv")


@app.get("/fileform")
async def main():
    content = """
<body>
<form action="/uploadcsv/" enctype="multipart/form-data" method="post">
<input name="csv_file" type="file" multiple>
<input type="submit">
</form>
</body>
    """
    return HTMLResponse(content=content)