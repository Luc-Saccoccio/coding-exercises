package main

import "fmt"

func main() {
	var n int
	var s string
	fmt.Scan(&n)
	for i := 0; i<n; i++ {
		fmt.Scan(&s)
		fmt.Println(solve(s))
	}
}

func solve(s string) string {
	n := len(s)
	if n > 10 {
		return fmt.Sprintf("%c%d%c", s[0], n-2, s[n-1])
	}
	return s
}
