package main

import "fmt"

type pair struct {
	a, b int
}

func main() {
	var n, a, b, c int
	fmt.Scan(&n)
	for i:=0; i<n; i++ {
		fmt.Scan(&a, &b)
		for c = 0; a!=0 && b!=0; {
			if a>b { c += a/b; a%=b } else {c += b/a; b%=a}
		}
		fmt.Println(c)
	}
}
