/// This program will scrape medical center address data from the county and university websites

package main

import (
	"bufio"
	"encoding/json"
	"log"
	"os"
	"path/filepath"
	"strings"
	"sync"

	"github.com/gocolly/colly/v2"
)

func main() {
	wg := sync.WaitGroup{}
	wg.Add(2)

	err := os.MkdirAll(filepath.Join("data", "secure"), os.ModePerm)
	if err != nil {
		log.Fatal(err)
	}

	fpath := filepath.Join("data", "secure", "medical_centers.jsonl")
	outFile, err := os.Create(fpath)
	if err != nil {
		log.Fatal(err)
	}
	defer outFile.Close()

	writer := bufio.NewWriter(outFile)

	// county center urls
	urls := scrape_urls()

	// scrape county centers
	go scrape_county_centers(urls, writer, &wg)

	// scrape_university
	go scrape_university_med_centers(writer, &wg)

	wg.Wait()

	writer.Flush()
}

// ScrapeResult is the result of the scraping the medical centers
type ScrapeResult struct {
	Name    string `json:"name"`
	Address string `json:"address"`
}

// scrape_urls scrapes the urls for the county centers from the main county page
func scrape_urls() []string {
	var urlList []string

	c := colly.NewCollector()

	c.OnHTML("a.elementor-post__thumbnail__link", func(e *colly.HTMLElement) {
		link := e.Attr("href")
		urlList = append(urlList, link)
	})

	c.OnRequest(func(r *colly.Request) {
		log.Println("Visiting", r.URL)
	})

	c.OnScraped(func(r *colly.Response) {
		log.Println("Finished", r.Request.URL)
	})

	c.Visit("https://cookcountyhealth.org/our-locations/")

	return urlList
}

// scrape_county_centers actually scrapes the county centers and collects their address and name
func scrape_county_centers(urls []string, writer *bufio.Writer, wg *sync.WaitGroup) {
	defer wg.Done()

	c := colly.NewCollector()

	c.OnHTML(".col-md-3", func(e *colly.HTMLElement) {
		name := e.DOM.Find("h2").First().Text()
		address := e.DOM.Find("h6").First().Text()
		// some had a newline symbol
		address = strings.Replace(address, "\n", "", -1)

		result := ScrapeResult{
			Name:    strings.TrimSpace(name),
			Address: strings.TrimSpace(address),
		}

		jsonData, err := json.Marshal(result)
		if err != nil {
			log.Fatal(err)
		}
		writer.WriteString(string(jsonData) + "\n")
	})

	c.OnRequest(func(r *colly.Request) {
		log.Println("Visiting", r.URL)
	})

	c.OnScraped(func(r *colly.Response) {
		log.Println("Finished", r.Request.URL)
	})

	for _, url := range urls {
		c.Visit(url)
	}
}

// scrape_university_med_centers scrapes the university medical centers and collects their address and name
func scrape_university_med_centers(writer *bufio.Writer, wg *sync.WaitGroup) {
	defer wg.Done()

	c := colly.NewCollector()

	c.OnHTML(".locations-content", func(e *colly.HTMLElement) {
		// is it that easy?
		name := e.DOM.Find("h3 > a").First().Text()
		address := e.DOM.Find("p").First().Text()
		// some had a newline symbol
		address = strings.Replace(address, "\n", "", -1)

		result := ScrapeResult{
			Name:    strings.TrimSpace(name),
			Address: strings.TrimSpace(address),
		}

		jsonData, err := json.Marshal(result)
		if err != nil {
			log.Fatal(err)
		}
		writer.WriteString(string(jsonData) + "\n")
	})

	c.OnRequest(func(r *colly.Request) {
		log.Println("Visiting", r.URL)
	})

	c.OnScraped(func(r *colly.Response) {
		log.Println("Finished", r.Request.URL)
	})

	c.Visit("https://www.uchicagomedicine.org/find-a-location?page=6&sortby=default")
}
