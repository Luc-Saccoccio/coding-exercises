/* Find the difference between the sum of the squares of the
 * first one hundred natural numbers and the square of the sum.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

unsigned int solution(int n) {
	unsigned int squares_sum = ((2*n+1)*(n+1)*(n))/6;
	unsigned int sum_squares = ((n+1)*n)*0.5;
	return(pow(sum_squares, 2) - squares_sum);
}

int main() {
	printf("%u\n", solution(100));
	return(0);
}
