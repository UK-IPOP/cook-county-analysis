/// This program will calculate the nearest pharmacy and medical center to each row in the wide records file
/// It will also calculate the average distance between each row and all other rows

package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"math"
	"os"
	"path/filepath"
	"strconv"

	"github.com/schollz/progressbar/v3"
)

func main() {
	err := os.MkdirAll("secure", os.ModePerm)
	if err != nil {
		log.Fatal(err)
	}

	var invalidRows = 0

	pharmacies := loadJsonLines(filepath.Join("secure", "source", "pharmacies.jsonl"))
	pharmacyPoints := makePoints(pharmacies)

	medicalCenters := loadJsonLines(filepath.Join("secure", "geocoded_medical_centers.jsonl"))
	medicalCenterPoints := makePoints(medicalCenters)

	inFilePath := filepath.Join("downloads", "wide_records.jsonl")
	file, err := os.Open(inFilePath)
	if err != nil {
		log.Fatal(err)
	}
	scanner := bufio.NewScanner(file)

	var data []map[string]string
	var points []IndexPoint
	var i = 0
	spinner := initializeSpinner()
	for scanner.Scan() {
		var row map[string]string
		err := json.Unmarshal(scanner.Bytes(), &row)
		if err != nil {
			log.Fatal(err)
		}

		point, extractionErr := extractPointFields(row)
		if extractionErr != nil {
			// this currently happens 2,086 times (as of 9/14/22)
			if extractionErr.Error() == "could not find a valid lat/long" {
				invalidRows++
				row["closest_pharmacy_km"] = ""
				row["closest_medical_center_km"] = ""
				data = append(data, row)
				err := spinner.Add(1)
				if err != nil {
					log.Fatal(err)
				}
				i++
				continue
			} else {
				// float parsing error
				log.Fatal(extractionErr)
			}
		} else {
			points = append(points, IndexPoint{
				Index: i,
				Point: point,
			})
		}

		minDist := minimumDistance(point, pharmacyPoints)
		row["closest_pharmacy_km"] = strconv.FormatFloat(minDist, 'f', 2, 64)

		minDist = minimumDistance(point, medicalCenterPoints)
		row["closest_medical_center_km"] = strconv.FormatFloat(minDist, 'f', 2, 64)

		data = append(data, row)
		err = spinner.Add(1)
		if err != nil {
			log.Fatal(err)
		}
		i++
	}
	err = spinner.Finish()
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("Skipped %d invalid rows", invalidRows)

	// now we have all the rows, and we can calculate the average distance between each point
	// first just get all the points that we have

	// now calculate the average distance between each point
	bar := initializeProgress(len(points), "Calculating average distance")
	for i, point := range points {
		otherPoints := append(points[:i], points[i+1:]...)
		averageDist := averageDistance(point.Point, otherPoints)
		// update the row
		data[point.Index]["average_distance"] = strconv.FormatFloat(averageDist, 'f', 2, 64)

		err = bar.Add(1)
		if err != nil {
			log.Fatal(err)
		}
	}
	err = bar.Finish()
	if err != nil {
		log.Fatal(err)
	}

	// write to file
	fpath := filepath.Join("secure", "records_with_distances.jsonl")
	outFile, err := os.Create(fpath)
	if err != nil {
		log.Fatal(err)
	}
	defer outFile.Close()

	writer := bufio.NewWriter(outFile)
	bar = initializeProgress(len(data), "Writing to file")
	for _, row := range data {
		rowBytes, err := json.Marshal(row)
		if err != nil {
			log.Fatal(err)
		}
		_, err = writer.WriteString(string(rowBytes) + "\n")
		if err != nil {
			log.Fatal(err)
		}
		err = bar.Add(1)
		if err != nil {
			log.Fatal(err)
		}
	}
	err = bar.Finish()
	if err != nil {
		log.Fatal(err)
	}
	err = writer.Flush()
	if err != nil {
		log.Fatal(err)
	}

}

// Point is a latitude and longitude
type Point struct {
	X float64
	Y float64
}

// IndexPoint is a point with an index
type IndexPoint struct {
	Index int
	Point Point
}

// extractPointFields extracts the latitude and longitude from a row
// this is smart and searches for the first valid lat/long
func extractPointFields(row map[string]string) (Point, error) {
	lat := row["latitude"]
	long := row["longitude"]
	// use geocoded lat/long if original not available
	if lat == "" || long == "" {
		lat = row["geocoded_latitude"]
		long = row["geocoded_longitude"]

		// check that these are also not empty
		if lat == "" || long == "" {
			// this currently happens 2,086 times (as of 9/14/22)
			// causes:
			// - missing lat/long in original secure
			// - missing lat/long in geocoded secure
			//    - this ^ is likely due to failure to geocode because of invalid address
			return Point{}, errors.New("could not find a valid lat/long")
		}
	}
	latFloat, err := strconv.ParseFloat(lat, 64)
	if err != nil {
		return Point{}, err
	}
	longFloat, err := strconv.ParseFloat(long, 64)
	if err != nil {
		return Point{}, err
	}
	return Point{latFloat, longFloat}, nil

}

// makePoints converts a slice of rows to a slice of points
func makePoints(records []map[string]interface{}) []Point {
	var points []Point
	for _, pharmacy := range records {
		lat := pharmacy["geocoded_latitude"].(float64)
		lon := pharmacy["geocoded_longitude"].(float64)
		points = append(points, Point{lat, lon})
	}
	return points
}

// loadJsonLines loads a jsonl file into a slice of maps
func loadJsonLines(fpath string) []map[string]interface{} {
	// read file
	file, err := os.Open(fpath)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	reader := bufio.NewScanner(file)
	var centers []map[string]interface{}
	for reader.Scan() {
		var center map[string]interface{}
		err = json.Unmarshal(reader.Bytes(), &center)
		if err != nil {
			log.Fatal(err)
		}
		centers = append(centers, center)
	}
	return centers
}

// minimumDistance returns the minimum distance between a point and a slice of points
func minimumDistance(p Point, points []Point) float64 {
	minDist := math.MaxFloat64
	for _, point := range points {
		dist := cosineDistance(p, point)
		if dist < minDist {
			minDist = dist
		}
	}
	return minDist
}

// averageDistance returns the average distance between a point and a slice of points
func averageDistance(p Point, points []IndexPoint) float64 {
	var totalDist float64
	var comparisons int
	for _, point := range points {
		dist := cosineDistance(p, point.Point)
		totalDist += dist
		comparisons++
	}
	average := totalDist / float64(comparisons)
	return average
}

// cosineDistance returns the cosine distance between two points
func cosineDistance(p1, p2 Point) float64 {
	// source: http://www.movable-type.co.uk/scripts/latlong.html
	// cosine distance
	R := 6371.0 // km
	// convert degrees to radians (lat)
	φ1 := p1.X * math.Pi / 180
	φ2 := p2.X * math.Pi / 180

	Δφ := (p2.X - p1.X) * math.Pi / 180
	Δλ := (p2.Y - p1.Y) * math.Pi / 180

	a := math.Sin(Δφ/2)*math.Sin(Δφ/2) + math.Cos(φ1)*math.Cos(φ2)*math.Sin(Δλ/2)*math.Sin(Δλ/2)
	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))
	d := R * c // distance in km
	return d
}

// initializeProgress initializes a pre-configured progress bar of a given length.
func initializeProgress(length int, message string) *progressbar.ProgressBar {
	bar := progressbar.NewOptions(length,
		progressbar.OptionEnableColorCodes(true),
		progressbar.OptionSetDescription("[blue]"+message),
		progressbar.OptionSpinnerType(14),
		progressbar.OptionShowCount(),
		progressbar.OptionSetWidth(25),
		progressbar.OptionSetTheme(progressbar.Theme{
			Saucer:        "[green]=[reset]",
			SaucerHead:    "[green]>[reset]",
			SaucerPadding: " ",
			BarStart:      "[",
			BarEnd:        "]",
		}),
		progressbar.OptionOnCompletion(func() {
			fmt.Println("Done!")
		}),
	)
	return bar
}

// initializeSpinner initializes a pre-configured spinner.
func initializeSpinner() *progressbar.ProgressBar {
	bar := progressbar.NewOptions(-1,
		progressbar.OptionEnableColorCodes(true),
		progressbar.OptionSetDescription("[blue]Calculating distances..."),
		progressbar.OptionSpinnerType(14),
		progressbar.OptionShowCount(),
		progressbar.OptionSetWidth(25),
		progressbar.OptionShowBytes(true),
		progressbar.OptionOnCompletion(func() {
			fmt.Println("Done!")
		}),
	)
	return bar
}
