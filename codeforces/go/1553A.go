package main

import "fmt"

func main() {
	var t, n int
	fmt.Scan(&t)
	for i:=0;i<t;i++ {
		fmt.Scan(&n)
		if n%10<9 {
			fmt.Println(n/10)
		} else {
			fmt.Println(n/10 +1)
		}
	}
}
