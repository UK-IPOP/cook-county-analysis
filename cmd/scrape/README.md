# Scrape

## Intro

This folder is for a simple Go program that scrapes data from [Cook County Health](https://cookcountyhealth.org/our-locations/) and [University of Chicago Medicine](https://www.uchicagomedicine.org/find-a-location?page=6&sortby=default) websites and extracts address data for later geocoding in an attempt to map/locate each medical center.


## Requirements

This program expects you to have run `scripts/fetch_release_data.sh` script (which fetches the Cook County Records (wide) from the opendata pipeline).

## Usage

The program will run directly from the command line using `go run cmd/scrape/main.go` from the project root directory.

## Process

This program will visit each of the medical center pages and extract the address data from the page. It will then write the address data to a file called `medical_centers.jsonl` in the `secure` data folder.

## Output

This program will produce a file called `medical_centers.jsonl` in the `secure` data folder. This file will contain a JSON object for each medical center with the following fields:

- name: The name of the medical center
- address: The address of the medical center
