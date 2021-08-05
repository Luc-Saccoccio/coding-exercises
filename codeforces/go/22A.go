package main

import "fmt"

func main() {
	var n, min, smin, i int
	smin_found := false
	fmt.Scan(&n)
	l := make([]int, n)
	fmt.Scan(&min)
	l[0] = min
	for i=1; i<n; i++ {
		fmt.Scan(&l[i])
		if l[i] < min {
			smin = min
			min = l[i]
			smin_found = true
		}
	}
	for i=0; !smin_found && i<n; i++ {
		if l[i] > min {
			smin = l[i]
			smin_found = true
		}
	}
	for ; i<n; i++ {
		if l[i] < smin && l[i] > min {
			smin = l[i]
		}
	}
	if smin_found {	fmt.Println(smin) } else {fmt.Println(min)}
}
