import geopandas as gpd
import pandas as pd

if __name__ == "__main__":
    print("Reading datasets...")
    land_use_shapes = gpd.read_file(
        "./resources/Chicago_LandUse_Shapes/Landuse2015_CMAP_v1.shp"
    )
    data_dict = pd.read_csv("./data/landuse_data_dictionary.csv")
    print("Merging datasets...")
    data_dict["LANDUSE"] = data_dict.landuse_id.apply(lambda x: str(x))
    geo_df = land_use_shapes.merge(data_dict, on="LANDUSE")
    print("Writing new shapefile...")
    geo_df.to_file("./data/LANDUSE_SHAPES/land_use.shp")
    print('Done.')
