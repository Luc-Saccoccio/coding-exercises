package main

import "fmt"

func main() {
	var n, m int
	fmt.Scanf("%d %d\n", &n, &m)
	rem := n%m
	base := n/m
	for i:=0; i<m; i++ {
		if rem > 0 {
			fmt.Printf("%d ", base+1)
			rem--
		} else {
			fmt.Printf("%d ", base)
		}
	}
}
