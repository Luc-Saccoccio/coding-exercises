package main

import "fmt"

func main() {
	var n int
	count := 0
	var s string
	fmt.Scan(&n)
	for i := 0; i<n; i++ {
		fmt.Scan(&s)
		update(&count, s)
	}
	fmt.Println(count)
}

func update(count *int, s string) {
	switch s {
	case "X++", "++X":
		*count++
	case "X--", "--X":
		*count--
	}
	return
}
