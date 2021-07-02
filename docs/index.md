# Geocoding Analysis

<img alt="Python" src="https://img.shields.io/badge/python-blue.svg?style=for-the-badge&logo=python&logoColor=yellow"/>

## Homepage

The GitHub homepage can be found [here](https://github.com/UK-IPOP/geocoding)

## Description

This project is designed to take the open-source dataset for the Chicago Medical Case Examiner's Notes ([here](https://datacatalog.cookcountyil.gov/Public-Safety/Medical-Examiner-Case-Archive/cjeq-bs86)) and combine it with the openly available Chicago Land Use datasets ([here](https://www.cmap.illinois.gov/data/land-use)) to analyze trends by Land Use area and geographic regions.

## Installation

Getting this project up and running locally is a multi-step process. First, you can clone the git repository onto your local machine and change into that directory.

```bash
git clone https://github.com/UK-IPOP/geocoding.git
cd geocoding
```

Then you can install the projects main dependencies:
`poetry install --no-dev` or install all dependencies (including development) using `poetry install`. Then activate the poetry created virtual environment by running `poetry shell`.

Now you're code environment is ready.

## Post-Installation Setup

However, before you run the pipeline, you need to do some preparation.

Firstly you need to download the shapefiles and extract the folder from the [Land Use Website](https://www.cmap.illinois.gov/data/land-use). Put the extracted folder into the `resources` folder inside the geocoding project.

You then need to go to the Chicago ME Records [website](https://datacatalog.cookcountyil.gov/Public-Safety/Medical-Examiner-Case-Archive/cjeq-bs86) and download their data in `*.csv` format and place it into the `data` directory of the geocoding project.

> \*These records will be geocoded which can take hours so it is recommended to pre-filter your data using the Cook County Open Data explorer.

## Methodology

In order to perform this analysis, we conducted all of the above steps regarding project setup. We extracted all of the ME Records on [**DATE**]. We then ran the pipeline and used the resulting data-file for analysis in **[PAPER]**. To see an example of potential analysis that could result from this, see our [Tutorial Notebook](https://github.com/UK-IPOP/geocoding/blob/main/notebooks/Analysis_Tutorial.ipynb).

## Pipeline Explanation

The pipeline has multiple stages that need to run in succession.

1. Take the raw Land Use files and apply the Data Dictionary (extracted from [this PDF](https://github.com/UK-IPOP/geocoding/blob/main/resources/Chicago_LandUseClassifications_2015.pdf)) to each Land Use polygon.
2. Geocode the pharmacies provided by Cook County.
3. Geocode Case Archive records.
4. Calculate the distance to the closest pharmacy from each Case Archive record.
5. Spatially join the Land Use shapes to the Case Archive records giving each record a corresponding Land Use category.

The following image may more clearly explain the data flow:

### Pipeline Flowchart

![Pipeline Flowchart Image](https://raw.githubusercontent.com/UK-IPOP/geocoding/main/resources/Geocoding%20Flowchart.png)

## Pipeline Usage

Running the pipeline is simple once you have everything setup.

Inside the home directory of the geocoding project simply run: `make pipeline`

This can take up to 12 hours depending on the system you are running and the number of ME records you are geocoding. Future efforts may be made to speed this process up using asynchronous geocoding.

If you wish to remove any steps from the pipeline those lines can simply be removed from the `Makefile`

## Support

For questions on implementation or issues you can either make a GitHub Issue or contact @nanthony007

## License

This project is GNU v3 Licensed which means that work you perform utilizing this project must attribute to this project (the source), you must disclose any source-changes you make, and your resulting work must also be GPLv3 Licensed.

## Citation

If you use this work, please cite:

@@@ citation
