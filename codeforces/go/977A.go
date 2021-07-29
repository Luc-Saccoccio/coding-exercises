package main

import (
	"fmt"
)

func main() {
	var n, k int
	fmt.Scanf("%d %d", &n, &k)
	for i := 0; i<k; i++ {
		divideByOne(&n)
	}
	fmt.Println(n)
}

func divideByOne(n *int) {
	if *n%10 == 0 {
		*n /= 10
	} else {
		*n -=1
	}
}
