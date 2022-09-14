# todo

current:

- [x] cleanup gitignore
  - [x] add golang gitignore
- [x] remove poetry env and config files
- [x] move xylazine to notebooks
  - [ ] cleanup xylazine folder, rename to xylazine analysis
  - [ ] put README inside notebooks folder (and xylazine folder?)
- [x] use go colly to scrape medical sites
- [x] use geocoode package + jq to geocode medical sites
- [x] use geocode package + jq to geocode pharmacies
- [x] use script to download release data
  - [x] adapt script to use `--patern` flag to only get cook county wide data
- [ ] write script to fetch geo data 
  - [ ] county shapefile
  - [ ] census tract shapefile
  - [ ] parks shapefile
  - [ ] assessors boundaries (x2) shapefile
- [x] use go to do cosine distance (between lots of things?)
- [ ] use GH codespace for development (i.e. linux environment thus can use poetry for geopandas)
- [ ] comment up the golang files
  - [ ] add docstrings
  - [ ] Add a README to each binary folder

once working:

- [ ] remove old scripts
- [ ] remove old data
- [x] delete other projects locally
  - [x] MIL
  - [x] medical centers scraper
- [ ] use (something like) fetch data script in cuyhoga analysis project
  - [ ] that analysis (ohio) should be getting updated as well
- [ ] update README