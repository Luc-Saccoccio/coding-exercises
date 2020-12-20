/* 2520 is the smallest number that can be divided by each of the
 * numbers from 1 to 10 without any remainder.
 * What is the smallest positive number that is evenly divisible
 * by all of the numbers from 1 to 20?
 */

#include <stdio.h>

int main(void) {
	int nums[8] = {16, 9, 5, 7, 11, 13, 17, 19};
	unsigned long ans = 1;
	for(int i=0; i<8; i++) {
		ans = ans * nums[i];
	}
	printf("%lu\n", ans);
	return(0);
}
