/* The prime factors of 13195 are 5, 7, 13 and 29.
 * What is the largest prime factor of the number 600851475143 ?
 */

#include <stdio.h>

int solution(unsigned long long n) {
	unsigned long long i;
	for(i=2ULL; i<n; i++) {
		printf("%llu\n", i);
		while(n%i == 0) {
			n /= i;
		}
	}
	return(n);
}

int main(void) {
	printf("%llu\n", solution(600851475143ULL));
	return(0);
}
