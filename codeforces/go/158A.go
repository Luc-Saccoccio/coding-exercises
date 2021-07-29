package main

import "fmt"

func main() {
	var n, k, i, count int
	fmt.Scanf("%d %d\n", &n, &k)
	l := make([]int, n)
	for i = 0; i<n; i++ {
		fmt.Scan(&l[i])
	}
	for i = 0; i<n; i++ {
		if l[i] > 0 && l[i] >= l[k-1] {
			count++
		}
	}
	fmt.Println(count)
}
