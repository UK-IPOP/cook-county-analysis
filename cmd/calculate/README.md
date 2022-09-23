# Calculate

## Intro

This folder is for a simple Go program that calculates the [haversine distance](https://en.wikipedia.org/wiki/Haversine_formula)
between various spatial points.

> Note: Unfortunately the pharmacy data we use cannot be shared and thus this is here for reference only.

## Requirements

This program expects you to have already run the `scrape` program in the cmd/scrape folder which will scrape down medical center data
which will then be used in this program.

It also expects you to have run `scripts/fetch_release_data.sh` script (which fetches the Cook County Records (wide) from the opendata pipeline) and the `scripts/geocode.sh` script which will geocode the medical centers *after* they have been scraped.

## Usage

The program will run directly from the command line using `go run cmd/calculate/main.go` from the project root directory.

## Process

This program will calculate the average distance to the between all *other* points in the dataset (from the perspective of the current point),
the distance to the nearest pharmacy and the distance to the nearest medical center all in kilometers.

## Output

This program will add the following fields to the `wide_records.jsonl` file that is produced by the `scripts/fetch_release_data.sh` script:

- `closest_pharmacy_km`
- `closest_medical_center_km`
- `average_distance`
