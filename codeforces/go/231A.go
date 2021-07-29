package main
 
import "fmt"
 
func main() {
	var n int
	var a, b, c int
	count := 0
	fmt.Scan(&n)
	for i := 0; i<n; i++ {
		fmt.Scanf("%d %d %d\n", &a, &b, &c)
		if a + b + c >= 2 {
			count++
		}
	}
	fmt.Println(count)
}
