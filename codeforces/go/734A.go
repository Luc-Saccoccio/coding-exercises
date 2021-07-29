package main

import (
	"fmt"
)

func main() {
	var n, ca, cd int
	// var s string
	var t rune
	fmt.Scan(&n)
	// fmt.Scan(&s)
	// for _, c := range s {
	// 	if c == 'D' {
	// 		cd++
	// 	} else {
	// 		ca++
	// 	}
	// }
	for i:=0; i<n; i++ {
		fmt.Scanf("%c", &t)
		if t == 'D' {
			cd++
		} else {
			ca++
		}
	}
	if ca > cd {
		fmt.Println("Anton")
	} else if cd > ca {
		fmt.Println("Danik")
	} else {
		fmt.Println("Friendship")
	}

}
