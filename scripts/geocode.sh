#! /bin/bash

# this script reads the medical centers file, geocodes them, and writes the results to a new file

rm -f secure/geocoded_medical_centers.jsonl

while read -r line; do
    
    name=$(jq -r '.name' <<< "$line")
    address=$(jq -r '.address' <<< "$line")

    geocode "$address" \
        --provider arcgis \
        --method geocode \
        --output json \
        | \
        jq -c --arg NAME "$name" '{name: $NAME, address, geocoded_latitude: .lat, geocoded_longitude: .lng, geocoded_score}' >> secure/geocoded_medical_centers.jsonl

done < secure/medical_centers.jsonl


# then convert to csv
jq -sr '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' secure/geocoded_medical_centers.jsonl > data/geocoded_medical_centers.csv
