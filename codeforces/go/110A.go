package main

import (
	"fmt"
)

func main() {
	var n string
	l := make(map[rune]int)
	fmt.Scan(&n)
	for _, c := range n {
		l[c]++
	}
	if isLucky(l['4']+l['7']) {
		fmt.Println("YES")
	} else {
		fmt.Println("NO")
	}
}	

func isLucky(n int) bool {
	for _, c := range fmt.Sprintf("%d", n) {
		if c != '4' && c != '7' {
			return false
		}
	}
	return true
}
