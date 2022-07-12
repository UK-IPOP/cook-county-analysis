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
	cases := readCsvFile("cases.csv")

	// find target lat/long cols for each dataset using first row headers
	casesLatIndex := findTargetColIndex("final_latitude", cases[0])
	casesLongIndex := findTargetColIndex("final_longitude", cases[0])

	var caseAvgDistances []float64
	bar := initializeProgress(len(cases) - 1)

	// skip header row
	for i, caseRow := range cases[1:] {
		caseLat, _ := strconv.ParseFloat(caseRow[casesLatIndex], 64)
		caseLong, _ := strconv.ParseFloat(caseRow[casesLongIndex], 64)
		if caseLat == 0.0 || caseLong == 0.0 {
			caseAvgDistances = append(caseAvgDistances, -1)
			err := bar.Add(1)
			if err != nil {
				log.Fatal("could not increment progress")
			}
			continue
		}
		var totalDist float64 = 0.0
		for j, caseRow2 := range cases[1:] {
			if i == j {
				continue
			}
			caseLat2, _ := strconv.ParseFloat(caseRow2[casesLatIndex], 64)
			caseLong2, _ := strconv.ParseFloat(caseRow2[casesLongIndex], 64)

			// find distance between case point and case2 point
			dist := distance(caseLat, caseLong, caseLat2, caseLong2)
			totalDist += dist
		}
		avgDist := totalDist / float64(len(cases)-1)

		err := bar.Add(1)
		if err != nil {
			log.Fatal("could not increment progress")
		}
		caseAvgDistances = append(caseAvgDistances, avgDist)
	}

	for i := range cases {
		if i == 0 {
			cases[i] = append(cases[i], "avg_distance")
			continue
		}
		cases[i] = append(cases[i], strconv.FormatFloat(caseAvgDistances[i-1], 'f', 4, 64))
	}
	// write to file
	f, err := os.Create("cases_with_distances.csv")
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

	// --------------------------------------
	controls := readCsvFile("controls.csv")

	// find target lat/long cols for each dataset using first row headers
	controlLatIndex := findTargetColIndex("final_latitude", controls[0])
	controlLongIndex := findTargetColIndex("final_longitude", controls[0])

	var controlAvgDistances []float64
	bar2 := initializeProgress(len(controls) - 1)

	// skip header row
	for i, controlRow := range controls[1:] {
		controlLat, _ := strconv.ParseFloat(controlRow[controlLatIndex], 64)
		controlLong, _ := strconv.ParseFloat(controlRow[controlLongIndex], 64)
		if controlLat == 0.0 || controlLong == 0.0 {
			controlAvgDistances = append(controlAvgDistances, -1)
			err := bar2.Add(1)
			if err != nil {
				log.Fatal("could not increment progress")
			}
			continue
		}
		var totalDist float64 = 0.0
		for j, controlRow2 := range controls[1:] {
			if i == j {
				continue
			}
			controlLat2, _ := strconv.ParseFloat(controlRow2[controlLatIndex], 64)
			controlLong2, _ := strconv.ParseFloat(controlRow2[controlLongIndex], 64)

			// find distance between control point and control2 point
			dist := distance(controlLat, controlLong, controlLat2, controlLong2)
			totalDist += dist
		}
		avgDist := totalDist / float64(len(controls)-1)

		err := bar2.Add(1)
		if err != nil {
			log.Fatal("could not increment progress")
		}
		controlAvgDistances = append(controlAvgDistances, avgDist)
	}

	for i := range controls {
		if i == 0 {
			controls[i] = append(controls[i], "avg_distance")
			continue
		}
		controls[i] = append(controls[i], strconv.FormatFloat(controlAvgDistances[i-1], 'f', 4, 64))
	}
	// write to file
	f, err = os.Create("controls_with_distances.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer func(f *os.File) {
		err := f.Close()
		if err != nil {
			log.Fatal(err)
		}
	}(f)
	csvwriter = csv.NewWriter(f)
	writeErr = csvwriter.WriteAll(controls)
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
