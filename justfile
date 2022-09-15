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
    rm data/medical_centers.jsonl
    rm ./scrape
    echo "Done."


calculate-distances: build scrape-centers
    echo "Calculating distances..."
    ./calculator
    rm ./calculator
    echo "Done."