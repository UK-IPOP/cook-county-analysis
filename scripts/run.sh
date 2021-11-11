#! /usr/bin/env bash

# python to load, preprocess, and geocode

echo "Running data processing"
poetry run python ./scripts/data_runner.py

# golang to calculate distance

echo "Bulding Go program"
./scripts/build.sh

echo "Running distance calculation"
./scripts/calculate-distance

echo "Extracting drugs"
# can run on clean cases because does not need geo-spatial information
.scripts/drug-extraction pipeline "./data/processed/cases_with_distances.csv" --id-col "casenumber" --target-col "combined_primary" --clean --format --format-type "csv"

cp ./scripts/output.csv ./data/drugs/primary_drugs.csv

# can run on clean cases because does not need geo-spatial information
./scripts/drug-extraction pipeline "./data/processed/cases_with_distances.csv" --id-col "casenumber" --target-col "secondarycause" --clean --format --format-type "csv"

cp ./scripts/output.csv ./data/drugs/secondary_drugs.csv

echo "Joining drugs"
poetry run python ./scripts/transform.py