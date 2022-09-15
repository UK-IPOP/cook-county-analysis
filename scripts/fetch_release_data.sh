#! /bin/bash

# super simple script to fetch the (latest) release secure from the github api using `gh` cli

# downloads release assets to downloads dir 
# AND converts it from csv to jsonlines using `dasel` and `jq`

# requires `gh` cli and `dasel` and `jq` to be installed

# make if not exists
mkdir -p downloads


echo "Fetching release data from github api..."
gh release download -R uk-ipop/open-secure-pipeline -D downloads --pattern 'cook_county_wide_form.csv' --clobber \
    && echo "Converting to jsonlines..." \
    && cat downloads/cook_county_wide_form.csv | dasel -r csv -w json . | jq -c '.' > downloads/wide_records.jsonl \
    && echo "Done!"
