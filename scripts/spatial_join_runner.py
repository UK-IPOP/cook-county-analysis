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
    geo_df.drop("index_right", axis=1, inplace=True)
    print("Joined census tracts.")
    geom_df = spatial_join.spatially_join(geo_df, geo_dict["census"])
    geom_df.drop('index_right', axis=1, inplace=True)
    print("Joined land use.")
    print("Dumping file...")
    spatial_join.write_joined_file(geom_df)
    print("Done.")
