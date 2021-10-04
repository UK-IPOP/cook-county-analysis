from geocoding import spatial_join

if __name__ == "__main__":
    print("Starting spatial join runner...")
    print("Loading files...")
    geo_dict = spatial_join.load_files()
    print("Making geo-points...")
    geo_points = spatial_join.make_point_geometries(geo_dict["case_archives"])
    print("Joining datasets...")
    geo_df = spatial_join.spatially_join(
        geo_points,
        geo_dict["land_use"],
    )
    print("Joined land use.")
    geo_df2 = spatial_join.spatially_join(
        geo_points,
        geo_dict["parks"],
    )
    print("Joined parks.")
    geo_df.drop("index_right", axis=1, inplace=True)
    # drop geom here so in future spatial joins we join on the land use
    geo_df2_5 = geo_df2[["casenumber", "park_name", "is_park"]].copy()
    geo_df3 = geo_df.merge(geo_df2_5, on="casenumber", how="left")
    print("Merged parks and landuse.")
    geom_df = spatial_join.spatially_join(geo_df3, geo_dict["census"])
    print("Joined census tracts.")
    geom_df.drop("index_right", axis=1, inplace=True)
    print("Dumping file...")
    spatial_join.write_joined_file(geom_df)
    print("Done.")
