this project now also utilizes neighborhood boundaries [source](https://data.cityofchicago.org/widgets/bbvz-uum9?mobile_redirect=true)

and the assessor's neighborhoods as well




 echo "Downloading Shapefiles..."

 # download
 wget https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714/download/LUI15shapefilev1.zip

 echo "Extracting Shapefiles..."
 # unzip
 unzip LUI15shapefilev1.zip -d resources

 echo "Cleaning up..."
 # cleanup
 rm LUI15shapefilev1.zip


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

