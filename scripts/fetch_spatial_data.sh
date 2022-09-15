#! /bin/bash

echo "Starting to download "

echo "Downloading LandUse Shapefiles..."
# this is 2015 LandUse
# source: https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714
# wget https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714/download/LUI15shapefilev1.zip -P downloads


echo "Downloading Census Shapefiles..."
# these are 2021 census
# source: https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2021.html
wget https://www2.census.gov/geo/tiger/TIGER2021/TRACT/tl_2021_17_tract.zip -P downloads


echo "Downloading Neighborhood Shapefiles..."
# this uses ODATA! 🙂
curl https://data.cityofchicago.org/api/odata/v4/y6yq-dbs2 | jq '.value' > downloads/neighborhoods.geojson


echo ""


echo "Done."