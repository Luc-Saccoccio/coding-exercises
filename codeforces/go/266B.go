package main

import (
	"fmt"
)

func main() {
	var n, t int
	var ts string
	fmt.Scanf("%d %d\n", &n, &t)
	fmt.Scan(&ts)
	s := []rune(ts)
	for j:=0; j<t; j++ {
		for i:=1; i<n; i++ {
			if s[i] == 'G' && s[i-1] == 'B' {
				s[i] = 'B'
				s[i-1] = 'G'
				i++
			}
		}
	}
	fmt.Println(string(s))
}

