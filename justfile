default:
    just --list


fetch:
    ./scripts/fetch_release_data.sh
    ./scripts/fetch_spatial_data.sh


scrape-centers:
    echo "Running scraper..."
    go run cmd/scrape/main.go
    echo "Geocoding scraped centers..."
    ./scripts/geocode.sh
    echo "Done."


calculate-distances: fetch scrape-centers
    echo "Calculating distances..."
    go run cmd/calculator/main.go
    echo "Done."


spatially-join: calculate-distances
    echo "Spatially joining..."
    python scripts/spatial_join.py
    echo "Done."

report: spatially-join
    echo "Generating report..."
    pandas_profiling data/records_with_spatial_data.csv reports/profile.html --title (date "+%Y-%m-%d") --minimal
    echo "Done."


cleanup:
    # downloaded files
    rm -r downloads
    # intermediate files (real files are .csv)
    rm secure/*.jsonl
    echo "Done."