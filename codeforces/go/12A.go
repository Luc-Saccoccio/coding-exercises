package main

import (
	"fmt"
)

func main() {
	var (
		l [3]string
	)
	for i:=0;i<3;i++ {
		fmt.Scan(&l[i])
	}
	for i:=0;i<3;i++ {
		if l[0][i] != l[2][2-i] { fmt.Println("NO"); return }
	}
	if l[1][0] != l[1][2] { fmt.Println("NO") } else { fmt.Println("YES") }
}
