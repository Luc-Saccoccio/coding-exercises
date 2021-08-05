#include<stdio.h>

int price(int k, int w) {
	int sum = 0;
	for (int i = 1; i<=w; i++) {
		sum += i*k;
	}
	return sum;
}

int main(void) {
	int k, n, w, borrowed;
	scanf("%d %d %d\n", &k, &n, &w);
	borrowed = price(k, w)-n;
	printf("%d\n", borrowed > 0 ? borrowed : 0);
	return 0;
}
