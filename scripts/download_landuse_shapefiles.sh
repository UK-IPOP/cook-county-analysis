# this file will download the shapefiles from chicago me office

echo "Downloading Shapefiles..."

# download
wget https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714/download/LUI15shapefilev1.zip

echo "Extracting Shapefiles..."
# unzip
unzip LUI15shapefilev1.zip -d resources

echo "Cleaning up..."
# cleanup
rm LUI15shapefilev1.zip

echo "Done."