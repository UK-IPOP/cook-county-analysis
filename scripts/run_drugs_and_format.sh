#! /usr/bin/env bash

echo "Extracting drugs"
# can run on clean cases because does not need geo-spatial information
./scripts/drug-extraction pipeline "./data/processed/clean_cases.csv" --id-col "casenumber" --target-col "combined_primary" --clean --format --format-type "csv"

cp ./scripts/output.csv ./data/drugs/primary_drugs.csv

# can run on clean cases because does not need geo-spatial information
./scripts/drug-extraction pipeline "./data/processed/clean_cases.csv" --id-col "casenumber" --target-col "secondarycause" --clean --format --format-type "csv"

cp ./scripts/output.csv ./data/drugs/secondary_drugs.csv

echo "Transforming drugs"
poetry run python ./scripts/transform_drugs.py

echo "Joining wide-form drugs and records"
poetry run python ./scripts/join_files.py