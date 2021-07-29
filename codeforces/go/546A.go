package main

import (
	"fmt"
)

func main() {
	var k, n, w, s int
	fmt.Scanf("%d %d %d", &k, &n, &w)
	for i := 1; i<=w; i++ {
		s += i*k
	}
	s = s-n
	if s < 0 {
		fmt.Println(0)
	} else {
		fmt.Print(s)
	}
}
