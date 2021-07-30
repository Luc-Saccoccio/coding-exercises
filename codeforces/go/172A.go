package main

import (
	"fmt"
	"bufio"
	"os"
)

func main() {
	var (
		n int
		s, common string
	)
	fmt.Scan(&n, &common)
	input := bufio.NewScanner(os.Stdin)
	input.Split(bufio.ScanWords)
	p := len(common)
	for i:=1; i<n; i++ {
		input.Scan()
		s = input.Text()
		for j:=0; j<p; j++ {
			if s[j] != common[j] { p=j; break }
		}
		if p == 0 {
			break
		}
	}
	fmt.Println(p)
}
