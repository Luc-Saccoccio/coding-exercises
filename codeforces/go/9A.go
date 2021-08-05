package main

import "fmt"

func main() {
	var Y, W int
	probability := [7]string{"", "1/1", "5/6", "2/3", "1/2", "1/3", "1/6"}
	fmt.Scan(&Y, &W)
	fmt.Println(probability[max(Y, W)])
}

func max(a, b int) int {
	if a>b { return a }
	return b
}
