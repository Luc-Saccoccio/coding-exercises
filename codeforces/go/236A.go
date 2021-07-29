package main

import "fmt"

func main() {
	var s string
	var count int
	l := make([]bool, 26)
	fmt.Scan(&s)
	for _, c := range s {
		l[c - 'a'] = true
	}
	for _, k := range l {
		if k {
			count++
		}
	}
	if count%2 == 0  {
		fmt.Println("CHAT WITH HER!")
	} else {
		fmt.Println("IGNORE HIM!")
	}
}
