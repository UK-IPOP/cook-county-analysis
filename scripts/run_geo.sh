#! /usr/bin/env bash

# python to load, preprocess, and geocode

echo "Running data processing"
poetry run python ./scripts/data_runner.py

# golang to calculate distance

echo "Running distance calculation"
./scripts/calculate-distance
