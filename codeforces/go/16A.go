package main

import "fmt"

func main() {
	var (
		n, m int
		invalid bool
		p, a string
	)
	fmt.Scan(&n, &m)
	for i:=0;i<n;i++ {
		fmt.Scan(&a)
		if p == a { invalid = true }
		if !equal(a) { invalid = true }
		p = a
		if invalid { fmt.Println("NO"); return }
	}
	fmt.Println("YES")
}

func equal(s string) bool {
	f := s[0]
	for i:=0;i<len(s);i++ {
		if s[i] != f { return false }
	}
	return true
}
