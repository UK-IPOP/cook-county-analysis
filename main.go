package main

// TODO: make errors more specific, make dirs if they don't exist, etc.

import (
	"encoding/csv"
	"log"
	"math"
	"os"
	"strconv"
	"strings"

	"github.com/schollz/progressbar/v3"
)

func main() {
	// need to handle errors
	cases := readCsvFile("data/processed/recovered_lat_long.csv")
	pharmacies := readCsvFile("data/raw/pharmacies.csv")
	// find target lat/long cols for each dataset using first row headers
	casesLat := findTargetColIndex("geocoded_latitude", cases[0])
	casesLong := findTargetColIndex("geocoded_longitude", cases[0])
	oldCasesLat := findTargetColIndex("latitude", cases[0])
	oldCasesLong := findTargetColIndex("longitude", cases[0])
	pharmLat := findTargetColIndex("geocoded_latitude", pharmacies[0])
	pharmLong := findTargetColIndex("geocoded_longitude", pharmacies[0])
	caseMinDistances := []float64{}
	oldVsNew := []float64{}
	bar := initializeProgress(len(cases) - 1)
	for _, caseRow := range cases[1:] {
		minDist := math.MaxFloat64
		caseLat, _ := strconv.ParseFloat(caseRow[casesLat], 64)
		caseLong, _ := strconv.ParseFloat(caseRow[casesLong], 64)
		oldLat, _ := strconv.ParseFloat(caseRow[oldCasesLat], 64)
		oldLong, _ := strconv.ParseFloat(caseRow[oldCasesLong], 64)
		if caseLat == 0 || caseLong == 0 || oldLat == 0 || oldLong == 0 {
			oldVsNew = append(oldVsNew, -1)
		}
		d := distance(caseLat, caseLong, oldLat, oldLong)
		oldVsNew = append(oldVsNew, d)
		for i, pharmRow := range pharmacies[1:] {
			// find distance between case and pharmacy

			pharmLat, _ := strconv.ParseFloat(pharmRow[pharmLat], 64)
			pharmLong, _ := strconv.ParseFloat(pharmRow[pharmLong], 64)
			dist := distance(caseLat, caseLong, pharmLat, pharmLong)
			if i == 1 || dist < minDist {
				minDist = dist
			}
		}
		caseMinDistances = append(caseMinDistances, minDist)
		bar.Add(1)
	}
	for i := range cases {
		if i == 0 {
			cases[i] = append(cases[i], "distance_between_points")
			cases[i] = append(cases[i], "closest_pharmacy")
			continue
		}
		cases[i] = append(cases[i], strconv.FormatFloat(oldVsNew[i-1], 'f', -1, 64))
		cases[i] = append(cases[i], strconv.FormatFloat(caseMinDistances[i-1], 'f', -1, 64))
	}
	// write to file
	f, err := os.Create("data/processed/cases_with_distances.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	csvwriter := csv.NewWriter(f)
	csvwriter.WriteAll(cases)
}

// need to return errors in all below functions

func readCsvFile(filePath string) [][]string {
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatal("Unable to read input file "+filePath, err)
	}
	defer f.Close()

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
	radlat1 := float64(math.Pi * lat1 / 180)
	radlat2 := float64(math.Pi * lat2 / 180)

	theta := float64(lng1 - lng2)
	radtheta := float64(math.Pi * theta / 180)

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
		progressbar.OptionSetDescription("[blue]Extracting drugs...[reset] "),
		progressbar.OptionSetTheme(progressbar.Theme{
			Saucer:        "[green]=[reset]",
			SaucerHead:    "[green]>[reset]",
			SaucerPadding: " ",
			BarStart:      "[",
			BarEnd:        "]",
		}))
	return bar
}
