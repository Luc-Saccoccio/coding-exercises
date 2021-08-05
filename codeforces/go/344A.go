package main

import "fmt"

func main() {
	var (
		n, count int = 0, 1
		p, a int
	)
	fmt.Scan(&n)
	fmt.Scan(&p)
	for i:=1; i<n; i++ {
		fmt.Scan(&a)
		if a != p { count ++ }
		p = a
	}
	fmt.Println(count)
}
