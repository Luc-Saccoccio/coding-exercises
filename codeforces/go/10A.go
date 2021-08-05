package main

import "fmt"

func main() {
	var n, p1, p2, p3, t1, t2, sum, l, r, pr int
	fmt.Scan(&n, &p1, &p2, &p3, &t1, &t2)
	consumption := func (time int) int {
		if time > t1+t2 {
			return p1*t1+p2*t2+p3*(time-t1-t2)
		} else if time > t1 {
			return p1*t1+p2*(time-t1)
		} else {
			return time*p1
		}
	}
	fmt.Scan(&l, &r)
	sum += p1*(r-l)
	pr = r
	for i:=1;i<n;i++ {
		fmt.Scan(&l, &r)
		sum += p1*(r-l)+consumption(l-pr)
		pr = r
	}
	fmt.Println(sum)
}
