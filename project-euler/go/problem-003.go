package main

import "fmt"

func solution(n int) int {
	for i := 2; i < n; i++ {
		for n%i == 0 {
			n /= i
		}
	}
	return n
}

func main() {
	fmt.Printf("%d", solution(600851475143))
}
