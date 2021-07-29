package main

import (
	"fmt"
)

func main() {
	var n, h, t, count int
	fmt.Scanf("%d %d\n", &n, &h)
	for i:=0; i<n; i++ {
		fmt.Scan(&t)
		if t>h {
			count += 2
		} else {
			count++
		}
	}
	fmt.Println(count)
}
