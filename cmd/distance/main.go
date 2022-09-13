package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	var i int
	var text []string
	for scanner.Scan() {
		t := scanner.Text()
		fmt.Println(i, t)
		text = append(text, t)
		i++
	}

	if scanner.Err() != nil {
		// Handle error.
		panic(scanner.Err())
	}

	fmt.Println("----------")
	fmt.Println("enter the path to the csv file")
	fmt.Println(len(text))

}
