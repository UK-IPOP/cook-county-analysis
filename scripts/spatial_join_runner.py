from geocoding import spatial_join

if __name__ == "__main__":
    print("Starting spatial join runner...")
    print("Loading files...")
    geo_dict = spatial_join.load_files()
    print("Making geo-points...")
    geo_points = spatial_join.make_point_geometries(geo_dict["case_archives"])
    print("Joining datasets...")
    merged_data = spatial_join.spatially_join(geo_points, geo_dict["land_use"])
    print("Dumping file...")
    spatial_join.write_joined_file(merged_data)
    print("Done.")
