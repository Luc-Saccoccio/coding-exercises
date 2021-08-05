package main

import "fmt"

func main() {
	var (
		n, d, a, p, count, delta int
	)
	fmt.Scan(&n, &d)
	fmt.Scan(&p, &a)
	if p >= a {
		delta = p-a
		a+=(delta/d+1)*d
		count+= delta/d+1
	}
	for i:=2; i<n; i++ {
		p = a
		fmt.Scan(&a)
		if p >= a {
			delta = p-a
			a+=(delta/d+1)*d
			count+= delta/d+1
		}
	}
	fmt.Println(count)
}
