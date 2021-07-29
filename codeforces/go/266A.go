package main

import "fmt"

func main() {
	var n, count int
	var s string
	fmt.Scan(&n)
	fmt.Scan(&s)
	for i := 1; i<len(s); i++ {
		if s[i-1] == s[i] {
			count++
		}
	}
	fmt.Println(count)
}
