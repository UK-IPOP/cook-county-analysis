# a REALLY basic one-liner to convert a JSONL file to CSV

# takes the current JSONL file name and the new CSV file name as arguments
# e.g. ./jsonl_to_csv.sh data/medical_centers.jsonl data/medical_centers.csv

jq -sr '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' $1 > $2