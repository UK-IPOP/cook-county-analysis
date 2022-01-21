package main

// TODO: make errors more specific, make dirs if they don't exist, etc.

import (
	"encoding/csv"
	"github.com/schollz/progressbar/v3"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
)

func main() {
	// need to handle errors
	cases := readCsvFile("data/processed/recovered_lat_long.csv")
	pharmacies := readCsvFile("data/raw/pharmacies.csv")
	// find target lat/long cols for each dataset using first row headers
	casesLatIndex := findTargetColIndex("final_latitude", cases[0])
	casesLongIndex := findTargetColIndex("final_longitude", cases[0])

	pharmLat := findTargetColIndex("geocoded_latitude", pharmacies[0])
	pharmLong := findTargetColIndex("geocoded_longitude", pharmacies[0])

	var caseMinDistances []float64
	bar := initializeProgress(len(cases) - 1)
	for _, caseRow := range cases[1:] {
		caseLat, _ := strconv.ParseFloat(caseRow[casesLatIndex], 64)
		caseLong, _ := strconv.ParseFloat(caseRow[casesLongIndex], 64)
		if caseLat == 0.0 || caseLong == 0.0 {
			caseMinDistances = append(caseMinDistances, -1)
			err := bar.Add(1)
			if err != nil {
				log.Fatal("could not increment progress")
			}
			continue
		}
		minDist := math.MaxFloat64
		for i, pharmRow := range pharmacies[1:] {
			// find distance between case point and pharmacy point
			pharmLat, _ := strconv.ParseFloat(pharmRow[pharmLat], 64)
			pharmLong, _ := strconv.ParseFloat(pharmRow[pharmLong], 64)
			dist := distance(caseLat, caseLong, pharmLat, pharmLong)
			if i == 0 || dist < minDist {
				minDist = dist
			}
		}
		caseMinDistances = append(caseMinDistances, minDist)
		err := bar.Add(1)
		if err != nil {
			log.Fatal("could not increment progress")
		}
	}
	for i := range cases {
		if i == 0 {
			cases[i] = append(cases[i], "closest_pharmacy")
			continue
		}
		cases[i] = append(cases[i], strconv.FormatFloat(caseMinDistances[i-1], 'f', -1, 64))
	}
	// write to file
	f, err := os.Create("data/processed/cases_with_distances.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer func(f *os.File) {
		err := f.Close()
		if err != nil {
			log.Fatal(err)
		}
	}(f)
	csvwriter := csv.NewWriter(f)
	writeErr := csvwriter.WriteAll(cases)
	if writeErr != nil {
		log.Fatal(writeErr)
	}
}

// need to return errors in all below functions

func readCsvFile(filePath string) [][]string {
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatal("Unable to read input file "+filePath, err)
	}
	defer func(f *os.File) {
		err := f.Close()
		if err != nil {
			log.Fatal(err)
		}
	}(f)

	csvReader := csv.NewReader(f)
	records, err := csvReader.ReadAll()
	if err != nil {
		log.Fatal("Unable to parse file as CSV for "+filePath, err)
	}

	return records
}

func findTargetColIndex(targetCol string, headers []string) int {
	for i, header := range headers {
		if strings.EqualFold(header, targetCol) {
			return i
		}
	}
	return -1
}

func distance(lat1 float64, lng1 float64, lat2 float64, lng2 float64) float64 {
	// formula taken from here: https://www.geodatasource.com/developers/go
	radlat1 := math.Pi * lat1 / 180
	radlat2 := math.Pi * lat2 / 180

	theta := lng1 - lng2
	radtheta := math.Pi * theta / 180

	dist := math.Sin(radlat1)*math.Sin(radlat2) + math.Cos(radlat1)*math.Cos(radlat2)*math.Cos(radtheta)

	if dist > 1 {
		dist = 1
	}

	dist = math.Acos(dist)
	dist = dist * 180 / math.Pi
	dist = dist * 60 * 1.1515

	return dist * 1.609344 // KM
}

// initializeProgress initializes a pre-configured progress bar of a given length.
func initializeProgress(length int) *progressbar.ProgressBar {
	bar := progressbar.NewOptions(length,
		progressbar.OptionEnableColorCodes(true),
		progressbar.OptionSetWidth(20),
		progressbar.OptionSetDescription("[blue]Calculating distances...[reset] "),
		progressbar.OptionSetTheme(progressbar.Theme{
			Saucer:        "[green]=[reset]",
			SaucerHead:    "[green]>[reset]",
			SaucerPadding: " ",
			BarStart:      "[",
			BarEnd:        "]",
		}))
	return bar
}
