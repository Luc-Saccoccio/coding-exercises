package main

import "fmt"

func main () {
	var n int
	fmt.Scan(&n)
	fmt.Print(solve(n))
}

func solve(n int) string {
	if n!= 2 && n%2 == 0 {
		return "YES"
	}
	return "NO"
}
