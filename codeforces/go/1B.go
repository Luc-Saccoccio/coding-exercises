package main

import (
	"fmt"
	"bytes"
)

func main() {
	var n int
	var s string
	fmt.Scan(&n)
	for i := 0; i < n; i++ {
		fmt.Scan(&s)
		fmt.Println(solve(s))
	}
}

func solve(s string) string {
	if s[0] == 'R' {
		i := 1
		for i < len(s) && isDigit(s[i]) {
			i++
		}
		if i > 1 && s[i] == 'C' {
			j := i+1
			for j < len(s) && isDigit(s[j]) {
				j++
			}
			if j == len(s) {
				var y int
				fmt.Sscan(s[i+1:], &y)
				return convertToLetters(y) + s[1:i]
			}
		}
	}
	num, i := 0, 0
	for i < len(s) && isUpper(s[i]) {
		num = num*26 + int(s[i]-'A')
		num++
		i++
	}
	return "R" + s[i:] + "C" + fmt.Sprintf("%d", num)
}

func convertToLetters(num int) string {
	var buf bytes.Buffer
	for num > 0 {
		num--
		x := byte(num%26 + 'A')
		buf.WriteByte(x)
		num =num / 26
	}
	bs := buf.Bytes()
	reverse(bs)
	return string(bs)
}

func reverse(s []byte) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func isUpper(x byte) bool {
	return x >= 'A' && x <= 'Z'
}

func isDigit(x byte) bool {
	return x >= '0' && x<= '9'
}
