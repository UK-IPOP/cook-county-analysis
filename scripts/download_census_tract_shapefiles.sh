# this file will download the shapefiles from the census 

echo "Downloading Shapefiles..."

# download
wget https://www2.census.gov/geo/tiger/TIGER2020/TRACT/tl_2020_17_tract.zip

mkdir resources/census_tracts

echo "Extracting Shapefiles..."
# unzip
unzip tl_2020_17_tract.zip -d resources/census_tracts

echo "Cleaning up..."
# cleanup
rm tl_2020_17_tract.zip

echo "Done."