package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"

	"github.com/schollz/progressbar/v3"
)

type Pair struct {
	Id1, Id2 int
}

func main() {
	// need to handle errors
	datasets := map[string][][]string{
		"alcoholCases":     readCsvFile("./alcohol_cases.csv"),
		"alcoholControls":  readCsvFile("./alcohol_controls.csv"),
		"fentanylCases":    readCsvFile("./fentanyl_cases.csv"),
		"fentanylControls": readCsvFile("./fentanyl_controls.csv"),
	}

	var allDistances []float64
	distanceMap := map[string]float64{}
	for name, dataset := range datasets {
		bar := initializeProgress(len(dataset)-1, name)

		latIndex := findTargetColIndex("final_latitude", dataset[0])
		longIndex := findTargetColIndex("final_longitude", dataset[0])

		var distances []float64
		for i, row := range dataset[1:] {
			lat, _ := strconv.ParseFloat(row[latIndex], 64)
			long, _ := strconv.ParseFloat(row[longIndex], 64)
			for j, row2 := range dataset[1:] {
				if i == j {
					// don't calculate distance between same point
					continue
				}
				lat2, _ := strconv.ParseFloat(row2[latIndex], 64)
				long2, _ := strconv.ParseFloat(row2[longIndex], 64)
				distances = append(distances, distance(lat, long, lat2, long2))
			}
			if err := bar.Add(1); err != nil {
				log.Fatal("could not increment progress")
			}
		}
		totalDistance := 0.0
		for _, distance := range distances {
			totalDistance += distance
		}
		avgDistance := totalDistance / float64(len(distances))
		distanceMap[name] = avgDistance
		allDistances = append(allDistances, distances...)
	}
	log.Println(distanceMap)
	var distanceMapArr [][]string
	for name, distance := range distanceMap {
		distanceMapArr = append(distanceMapArr, []string{name, strconv.FormatFloat(distance, 'f', 2, 64)})
	}
	// write to file
	f, err := os.Create("./distance_groups.csv")
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
	writeErr := csvwriter.WriteAll(distanceMapArr)
	if writeErr != nil {
		log.Fatal(writeErr)
	}

	totalDistances := 0.0
	for _, distance := range allDistances {
		totalDistances += distance
	}
	avgDistance := totalDistances / float64(len(allDistances))
	log.Println("Average distance across all points:", avgDistance, "miles.")
}

func isCompleted(i int, j int, pointList []Pair) bool {
	var pair Pair
	if i < j {
		pair = Pair{i, j}
	} else {
		pair = Pair{j, i}
	}
	for _, point := range pointList {
		if point == pair {
			return true
		}
	}
	return false
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

	// return dist * 1.609344 // KM
	return dist // miles
}

// initializeProgress initializes a pre-configured progress bar of a given length.
func initializeProgress(length int, description string) *progressbar.ProgressBar {
	bar := progressbar.NewOptions(length,
		progressbar.OptionEnableColorCodes(true),
		progressbar.OptionSetWidth(20),
		progressbar.OptionClearOnFinish(),
		progressbar.OptionSetDescription(fmt.Sprintf("[blue]Calculating distances (%s)...[reset] ", description)),
		progressbar.OptionSetTheme(progressbar.Theme{
			Saucer:        "[green]=[reset]",
			SaucerHead:    "[green]>[reset]",
			SaucerPadding: " ",
			BarStart:      "[",
			BarEnd:        "]",
		}))
	return bar
}
