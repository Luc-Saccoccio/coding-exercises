package main

import (
	"fmt"
)

func main() {
	var n, p, q, count int
	fmt.Scan(&n)
	for i := 0; i<n; i++ {
		fmt.Scanf("%d %d\n", &p, &q)
		if q-p >= 2 {
			count++
		}
	}
	fmt.Println(count)
}
