package main

import (
	"fmt"
)

func main() {
	var n, m, a int
	fmt.Scan(&n, &m, &a)
	fmt.Printf("%d", solve(n, m, a))
}

func solve(n, m, a int) int64 {
	N, M, A := int64(n), int64(m), int64(a)

	x, y := (N + A - 1) / A, (M + A - 1) / A
	return x * y
}
