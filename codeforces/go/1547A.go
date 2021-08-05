package main

import (
	"fmt"
)

func main() {
	var (
		xa, ya, xb, yb, xf, yf, t int
	)
	fmt.Scan(&t)
	for i:=0;i<t;i++ {
		fmt.Scan(&xa, &ya, &xb, &yb, &xf, &yf)
		if aligned(xa, xb, xf, ya, yb, yf) || aligned(ya, yb, yf, xa, xb, xf) {
			fmt.Println(abs(xa-xb) + abs(ya-yb)+2)
		} else {
			fmt.Println(abs(xa-xb) + abs(ya-yb))
		}
	}
}

func abs(n int) int {
	if n < 0 { return -n }
	return n
}

func aligned(x1, x2, x3, x4, x5, x6 int) bool {
	return equal(x1, x2, x3) && between(x4, x5, x6)
}

func equal(x1, x2, x3 int) bool {
	return x1 == x2 && x1 == x3
}

func between(x1, x2, x3 int) bool {
	return (x1 < x3) == (x3 < x2)
}
