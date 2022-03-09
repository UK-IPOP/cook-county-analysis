
set drugs cocaine heroin fentanyl

for drug in $drugs
    rg $drug data/raw/cases.csv --smart-case
end
