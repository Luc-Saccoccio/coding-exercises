package main

import (
	"fmt"
	"sort"
)

func main() {
	var n int
	fmt.Scan(&n)
	years := make([]int, n)
	for i:=0;i<n;i++ {
		fmt.Scan(&years[i])
	}
	sort.Ints(years)
	fmt.Println(years[len(years) / 2])
}
