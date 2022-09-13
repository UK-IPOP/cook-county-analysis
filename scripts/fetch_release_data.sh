#! /bin/bash

# super simple script to fetch the (latest) release data from the github api using `gh` cli

# downloads release assets to assets/ directory
gh release download latest -R uk-ipop/open-data-pipeline -D assets