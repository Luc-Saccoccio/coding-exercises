package main

import "fmt"

func main() {
	var x int
	for i := 1; i<=5; i++ {
		for k := 1; k<=5; k++ {
			fmt.Scan(&x)
			if x == 1 {
				fmt.Printf("%d\n", abs(i-3) + abs(k-3))
			}
		}
	}
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}
