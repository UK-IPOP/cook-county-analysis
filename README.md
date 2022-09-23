# Cook County Analysis

## Intro

This project consumes *enhanced* Cook County Medical Examiner data from our [opendata pipeline](https://github.com/UK-IPOP/open-data-pipeline)
and performs various analyses on it. The source data is from the Cook County Medical Examiner Archives [source](https://datacatalog.cookcountyil.gov/Public-Safety/Medical-Examiner-Case-Archive/cjeq-bs86) but is enhanced by our pipeline.

## Project Info

This project uses two simple Go programs to scrape medical center addresses and calculate haversine distance between points.

> Note: This project uses some closed data that cannot be shared and thus this documentation is for reference only.

## Requirements

Links not provided as these should be easy to find and only certain versions are required.

- Go 1.19
- Python 3.10
- git (git lfs)
- jq
- wget
- unzip
- dasel
- poetry (python)
- geocoder (python)

## Analysis

Analysis can be found in the `notebooks` folder.


If you base your work on any of this code, please cite this repository as follows:

```BibTeX
@software{Anthony_Medical_Examiner_OpenData_2022,
author = {Anthony, Nicholas},
month = {9},
title = {{Medical Examiner OpenData Pipeline}},
url = {https://github.com/UK-IPOP/open-data-pipeline},
version = {0.2.1},
year = {2022}
}
```
