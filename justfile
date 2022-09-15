default:
    just --list


fetch:
    ./scripts/fetch_release_data.sh


build:
    echo "Building scraper..."
    go build -o scrape ./cmd/scrape
    echo "Building distance calculator..."
    go build -o calculator ./cmd/calculator
    echo "Done."


scrape-centers: build
    echo "Running scraper..."
    ./scrape
    echo "Geocoding scraped centers..."
    ./scripts/geocode.sh
    echo "Done."


calculate-distances: scrape-centers
    echo "Calculating distances..."
    ./calculator
    rm ./calculator
    echo "Done."


spatially-join: calculate-distances
    echo "Spatially joining..."
    ./scripts/spatially_join.sh
    echo "Done."

report: spatially-join
    echo "Generating report..."
    pandas_profiling data/records_with_spatial_data.csv reports/profile.html --title (date "+%Y-%m-%d") --pool_size 4
    echo "Done."


cleanup:
    # downloaded files
    rm -r downloads
    # intermediate files (real files are .csv)
    rm secure/*.jsonl
    # binaries
    rm ./scrape
    rm ./calculator
    echo "Done."