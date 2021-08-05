package main

import "fmt"

func main() {
	var n, t int
	fmt.Scan(&n)
	l := make(map[int]int, n+1)
	for i:=1; i<=n; i++ {
		fmt.Scan(&t)
		l[t] = i
	}
	for i:=1; i<=n; i++ {
		fmt.Println(l[i])
	}
}
