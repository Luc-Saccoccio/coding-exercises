/* A palindromic number reads the same both ways.
 * The largest palindrome made from the product of two 2-digit
 * numbers is 9009 = 91 × 99.
 * Find the largest palindrome made from the product of
 * two 3-digit numbers.
 */

#include <stdio.h>

int test_palindrome(int n) {
	int t = n, r;
	while(t!=0) {
		r = r * 10;
		r += t%10;
		t = t/10;
	}
	if (n==r)
		return 1;
	else
		return 0;
}

int solution_v2(void) {
	int palindrome = 0, prod;
	for(int i=1000; i>=100; i -= 1) {
		printf("Hey");
		for (int j=1000; j>=i; i -= 1) {
			prod = i * j;
			if(test_palindrome(prod) && prod > palindrome) {
				palindrome = prod;
			}
		}
	}
	return(palindrome);
}

int main(void) {
	int a = solution_v2();
	printf("Value: %d", a);
	return(0);
}
