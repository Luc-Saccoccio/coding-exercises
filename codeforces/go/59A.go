package main

import (
	"fmt"
	"strings"
	"unicode"
)

func main() {
	var s string
	var cu, cl int
	fmt.Scan(&s)
	for _, c := range(s) {
		if unicode.IsUpper(c) {
			cu++
		} else {
			cl++
		}
	}
	if cu > cl {
		fmt.Println(strings.ToUpper(s))
	} else {
		fmt.Println(strings.ToLower(s))
	}
}
