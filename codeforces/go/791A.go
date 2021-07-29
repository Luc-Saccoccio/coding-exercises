package main

import (
	"fmt"
)

func main() {
	var a, b, count int
	fmt.Scanf("%d %d", &a, &b)
	for !(b<a) {
		a *= 3
		b *= 2
		count++
	}
	fmt.Println(count)
}
