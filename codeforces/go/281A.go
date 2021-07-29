package main

import (
	"fmt"
	"unicode"
)

func main() {
	var s string
	fmt.Scan(&s)
	fmt.Print(string(unicode.ToUpper(rune(s[0]))) + s[1:])
}
