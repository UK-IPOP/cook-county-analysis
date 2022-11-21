#! /bin/bash

# this script expects you to have scraped the medical centers from the web
# it will geocode the medical center addresses and write the geocoded results to file

# requires `jq` and `geocoder` to be installed see README.md for details

rm -f data/secure/geocoded_medical_centers.jsonl

while read -r line; do
    
    name=$(jq -r '.name' <<< "$line")
    address=$(jq -r '.address' <<< "$line")

    geocode "$address" \
        --provider arcgis \
        --method geocode \
        --output json \
        | \
        jq -c --arg NAME "$name" '{name: $NAME, address, geocoded_latitude: .lat, geocoded_longitude: .lng, geocoded_score}' >> data/secure/geocoded_medical_centers.jsonl

done < data/secure/medical_centers.jsonl


# then convert to csv
jq -sr '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' data/secure/geocoded_medical_centers.jsonl > data/geocoded_medical_centers.csv
