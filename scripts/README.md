# Scripts Folder

This folder contains all the scripts to prepare this data for analysis.

All downloaded data goes into the `downloads` folder. And generated data usually goes into `secure`.

For more details on each script, see the source file itself.

## Scripts

- `fetch_release_data.sh`
  - This script downloads the release data from our [opendata pipeline](https://github.com/UK-IPOP/open-data-pipeline) and gets only the Cook County wide format csv file
- `fetch_spatial_data.sh`
  - This script downloads LandUse patterns for Cook County
- `geocode.sh`
  - This script geocodes the scraped medical center data
- `spatial_join.py`
  - This script performs various spatial joins to the Cook County records
