
declare -a drugs=("drugs" "cocaine" "heroin" "fentanyl")

for drug in ${drugs[@]}; do
    rgss $drug data/raw/cases.csv --smart-case
done
