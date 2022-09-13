# todo

current:

- [ ] cleanup gitignore
  - [ ] add golang gitignore
- [ ] create conda environment
  - [ ] add conda to gitignore
  - [ ] remove poetry env and config files
- [x] move xylazine to notebooks
  - [ ] cleanup xylazine folder, rename to xylazine analysis
  - [ ] put README inside notebooks folder (and xylazine folder?)
- [ ] use go colly to scrape medical sites
- [ ] use geocoode package + jq to geocode medical sites
- [ ] use geocode package + jq to geocode pharmacies
- [ ] use script to download release data
  - [ ] adapt script to use `--patern` flag to only get cook county wide data
- [ ] write script to fetch geo data 
  - [ ] county shapefile
  - [ ] census tract shapefile
  - [ ] parks shapefile
  - [ ] assessors boundaries (x2) shapefile
- [ ] use GH codespace for development (i.e. linux environment thus can use poetry for geopandas)


once working:

- [ ] remove old scripts
- [ ] remove old data
- [ ] delete other projects locally
  - [ ] MIL
  - [ ] medical centers scraper
- [ ] use fetch data script in cuyhoga analysis project
  - [ ] this analysis should be getting updated as well
- [ ] update README