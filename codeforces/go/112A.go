package main

import (
	"fmt"
	"strings"
)

func main() {
	var s1, s2 string
	fmt.Scan(&s1)
	fmt.Scan(&s2)
	s1, s2 = strings.ToLower(s1), strings.ToLower(s2)
	if s1 == s2 {
		fmt.Println(0)
	} else if s1 > s2 {
		fmt.Println(1)
	} else {
		fmt.Println(-1)
	}
}
