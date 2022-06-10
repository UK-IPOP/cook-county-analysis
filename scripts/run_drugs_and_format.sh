#! /usr/bin/env bash

echo "Extracting drugs..."

# can run on clean cases because does not need geo-spatial information
de-workflow \
    execute \
    --algorithm="osa" \
    ./data/processed/clean_cases.csv \
    "casenumber" \
    "primary_combined" \
    "secondarycause"


mv ./merged_results.csv ./data/drugs/
mv ./dense_results.csv ./data/output/
mv ./report.html ./data/output/

echo "Reformatting drugs"
poetry run python ./scripts/reformat_drugs.py
