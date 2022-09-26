package main

import (
	"encoding/csv"
	"fmt"
	"math"
	"os"
	"strconv"

	"github.com/schollz/progressbar/v3"
)

func main() {
	file, err := os.Open("./combined.csv")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	csvReader := csv.NewReader(file)
	records, err := csvReader.ReadAll()
	if err != nil {
		panic(err)
	}

	groups := make(map[string][]Point)
	for i, record := range records {
		if i == 0 {
			continue
		}
		// last column is group
		group := record[len(record)-1]
		stringLat := record[30]
		stringLong := record[31]
		if stringLat == "" || stringLong == "" {
			continue
		}
		lat, err := strconv.ParseFloat(stringLat, 64)
		if err != nil {
			panic(err)
		}
		long, err := strconv.ParseFloat(stringLong, 64)
		if err != nil {
			panic(err)
		}
		p := Point{X: lat, Y: long, Group: group}
		groups[group] = append(groups[group], p)
	}

	var results []Result
	// for each group, calculate the distance between all points
	for group, points := range groups {
		pb := initializeProgress(len(points), "Processing group "+group)

		var groupDistances []float64
		for i, p1 := range points {
			var pointDistances []float64
			for j, p2 := range points {
				if i == j {
					continue
				}
				distance := cosineDistance(p1, p2)
				pointDistances = append(pointDistances, distance*0.621371) // convert to miles
			}
			// add distances to group
			groupDistances = append(groupDistances, pointDistances...)
			pb.Add(1)
		}
		// calculate average distance
		var totalDist float64
		for _, d := range groupDistances {
			totalDist += d
		}
		avgDist := totalDist / float64(len(groupDistances))
		fmt.Println("Average distance for group", group, "is", avgDist, "miles across", len(points), "points")

		results = append(results, Result{Group: group, AvgDistance: avgDist, NumPoints: len(points)})
	}

	// write results to csv file
	f, err := os.Create("./distance_results.csv")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	w := csv.NewWriter(f)
	defer w.Flush()

	// write header
	err = w.Write([]string{"group", "avg_distance(miles)", "num_points"})
	if err != nil {
		panic(err)
	}

	// write results
	for _, result := range results {
		err = w.Write([]string{result.Group, fmt.Sprintf("%f", result.AvgDistance), fmt.Sprintf("%d", result.NumPoints)})
		if err != nil {
			panic(err)
		}
	}
}

type Result struct {
	Group       string
	AvgDistance float64
	NumPoints   int
}

// Point is a latitude and longitude
type Point struct {
	X     float64
	Y     float64
	Group string
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
