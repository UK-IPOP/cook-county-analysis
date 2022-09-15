# todo

current:

- [x] cleanup gitignore
  - [x] add golang gitignore
- [x] remove poetry env and config files
- [x] use go colly to scrape medical sites
- [x] use geocoode package + jq to geocode medical sites
- [x] use geocode package + jq to geocode pharmacies
- [x] use script to download release data
  - [x] adapt script to use `--patern` flag to only get cook county wide data
- [x] write script to fetch geo data 
  - [x] county shapefile (for Illinois specifically)
    -  https://www2.census.gov/geo/tiger/GENZ2018/shp/cb_2018_17_cousub_500k.zip
  - [x] census tract shapefile
    - source: https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2021.html
  - [x] parks shapefile
    - https://hub-cookcountyil.opendata.arcgis.com/datasets/74d19d6bd7f646ecb34c252ae17cd2f7_7/about
  - [x] municialities shapefile
    - source: https://hub-cookcountyil.opendata.arcgis.com/datasets/534226c6b1034985aca1e14a2eb234af_2/about
    - https://gis.cookcountyil.gov/traditional/rest/services/politicalBoundary/MapServer/2/query?outFields=*&where=1%3D1&f=geojson
  - [x] neighborhoods
    - source: https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Neighborhoods/bbvz-uum9
    - via OData API: https://data.cityofchicago.org/api/odata/v4/y6yq-dbs2
  - [x] land Use
    - source: https://datahub.cmap.illinois.gov/dataset/e2bec582-3a98-499b-97b0-75a039de29cc/resource/60bd80da-c2b7-4243-a30b-775729da8714
- [x] use go to do cosine distance (between lots of things?)
- [x] use GH codespace for development (i.e. linux environment thus can use poetry for geopandas)


- [ ] comment up the golang files
  - [ ] add docstrings
  - [ ] Add a README to each binary folder
- [x] move xylazine to notebooks
  - [ ] cleanup xylazine folder, rename to xylazine analysis
  - [ ] put README inside notebooks folder (and xylazine folder?)
- [ ] remove justfile
