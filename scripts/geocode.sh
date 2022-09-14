#! /bin/bash

# this script reads the medical centers file, geocodes them, and writes the results to a new file

while read -r line; do
    name=$(jq -r '.name' <<< "$line")
    address=$(jq -r '.address' <<< "$line")

    geocode "$address" \
        --provider arcgis \
        --method geocode \
        --output json \
        | \
        jq -c --arg NAME "$name" '{name: $NAME, address, latitude: .lat, longitude: .lng, score}' > data/geocoded_medical_centers.jsonl

done < data/medical_centers.jsonl