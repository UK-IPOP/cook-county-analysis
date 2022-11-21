#! /bin/bash

# simply fetches the spatial data from the city of chicago data portal
# and unzips it into the downlaods folder

# requires `wget` and `unzip` to be installed see README.md for details

echo "Starting to download "

# make if not exists
mkdir -p data/downloads

echo "Downloading LandUse Shapefiles..."
# this is 2015 LandUse
wget https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714/download/LUI15shapefilev1.zip -P downloads

unzip data/downloads/LUI15shapefilev1.zip -d data/downloads/

echo "Done."