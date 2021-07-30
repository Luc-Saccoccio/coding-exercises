package main

import (
	"fmt"
)

func main() {
	var x, y, z, t1, t2, t3 int
	fmt.Scan(&x, &y, &z, &t1, &t2, &t3)
	e := abs(x-y)*t1
	a := (abs(x-z) + abs(x-y))*t2 + 3*t3
	if e >= a { fmt.Println("YES") } else { fmt.Println("NO") }
}

func abs(n int) int {
	if n < 0 { return -n }
	return n
}
