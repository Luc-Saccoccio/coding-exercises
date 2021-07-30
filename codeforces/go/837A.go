package main

import (
	"fmt"
	"strings"
	"bufio"
	"os"
	"unicode"
)

func main() {
	var (
		n, m, t int
		s string
	)
	fmt.Scanln(&n)
	input := bufio.NewReader(os.Stdin)
	s, _ = input.ReadString('\n')
	for _, word := range strings.Fields(s) {
		t = volume(word)
		if t > m { m = t }
	}
	fmt.Println(m)
}

func volume(s string) int {
	var n int
	for _, c := range s {
		if unicode.IsUpper(c) { n++ }
	}
	return n
}
