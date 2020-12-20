/* If we list all the natural numbers below 10 that are multiples of 3 or 5,
 * we get 3, 5, 6 and 9. The sum of these multiples is 23.
 *
 * Find the sum of all the multiples of 3 or 5 below 1000.
 */

#include <stdio.h>

int somme_divisible(int n) {
	int p = 999/n;
	return(n*(p*(p+1))/2);
}

int solution_v1(void) {
	int S = 0;
	for(int i = 1;i<=1000;i++) {
		if((i%3 == 0) || (i%5 == 0)) {
			S += i;
		}
	}
	return(S);
}

int solution_v2(void) {
	return(somme_divisible(3) + somme_divisible(5) - somme_divisible(15));;
}

int main(void) {
	// printf("Valeur 1 : %d\n", solution_v1());;
	printf("Valeur 2 : %d\n", solution_v2());;
	return(0);
}
