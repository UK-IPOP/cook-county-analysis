import geopandas as gpd
import pandas as pd
from pathlib import Path

fpath = Path("downloads") / "LUI15shapefilev1.zip#Landuse2015_CMAP_v1"
gdf = gpd.read_file(f"zip://{fpath}")

# gdf = gpd.read_file("LUI15_shapefile_v1/Landuse2015_CMAP_v1.shp")

# census works
# landuse doesnt...

print(gdf.head())
