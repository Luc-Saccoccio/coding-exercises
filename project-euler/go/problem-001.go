package main

import "fmt"

func somme_divisible(n int) int {
	p := 999 / n
	return n*(p*(p+1))/2
}

func main() {
	solution := somme_divisible(3) + somme_divisible(5) - somme_divisible(15)
	fmt.Printf("%d\n", solution)
}
