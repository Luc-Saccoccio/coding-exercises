package main

import "fmt"

func main() {
	var n, t, m int
	var a, b int
	fmt.Scan(&n)
	for i := 0; i<n; i++ {
		fmt.Scanf("%d %d\n", &a, &b)
		t = t - a + b
		if t > m {
			m = t
		}
	}
	fmt.Println(m)
}
