import pandas as pd
import geopandas as gpd
from shapely.geometry import Point
import numpy as np
from rich import print
import matplotlib.pyplot as plt


# xylazine fentanyl
df = pd.read_csv("./xylazine_matched_fentanyl.csv")
points = [
    Point(x, y)
    for (x, y) in df[["composite_longitude", "composite_latitude"]].to_numpy()
]
print(points[:2])

gdf = gpd.GeoDataFrame(df, geometry=points, crs="EPSG:4326").to_crs(
    "+proj=merc +lat_ts=41.9"
)
print(gdf.head())
gdf.plot()
plt.show()

gdf["x_coord"] = gdf["geometry"].apply(lambda x: x.x)
gdf["y_coord"] = gdf["geometry"].apply(lambda x: x.y)
dropcols = ["geometry"]
gdf.drop(columns=dropcols).to_csv("projected_xylazine_fentanyl.csv", index=False)

# xylazine alcohol
df = pd.read_csv("./xylazine_matched_alcohol.csv")
points = [
    Point(x, y)
    for (x, y) in df[["composite_longitude", "composite_latitude"]].to_numpy()
]
print(points[:2])

gdf = gpd.GeoDataFrame(df, geometry=points, crs="EPSG:4326").to_crs(
    "+proj=merc +lat_ts=41.9"
)
print(gdf.head())
gdf.plot()
plt.show()

gdf["x_coord"] = gdf["geometry"].apply(lambda x: x.x)
gdf["y_coord"] = gdf["geometry"].apply(lambda x: x.y)
dropcols = ["geometry"]
gdf.drop(columns=dropcols).to_csv("projected_xylazine_alcohol.csv", index=False)


# xylazine stimulant
df = pd.read_csv("./xylazine_matched_stimulant.csv")
points = [
    Point(x, y)
    for (x, y) in df[["composite_longitude", "composite_latitude"]].to_numpy()
]
print(points[:2])

gdf = gpd.GeoDataFrame(df, geometry=points, crs="EPSG:4326").to_crs(
    "+proj=merc +lat_ts=41.9"
)
print(gdf.head())
gdf.plot()
plt.show()

gdf["x_coord"] = gdf["geometry"].apply(lambda x: x.x)
gdf["y_coord"] = gdf["geometry"].apply(lambda x: x.y)
dropcols = ["geometry"]
gdf.drop(columns=dropcols).to_csv("projected_xylazine_stimulant.csv", index=False)
