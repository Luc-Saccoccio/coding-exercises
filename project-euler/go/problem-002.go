package main

import "fmt"

func not(n int) int {
	if n == 0 {
		return 1
	}
	return 0
}

func solution() int {
	a1, a2, a3, sum := 0, 1, 2, 0
	for a3 < 4e6 {
		a3 = a1 + a2
		sum += a3 * not(a3%2)
		a1 = a2
		a2 = a3
	}
	return sum
}

func main() {
	fmt.Printf("%d\n", solution())
}
