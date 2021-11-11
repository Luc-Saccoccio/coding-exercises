#include<stdio.h>

int main(void) {
	int n, k, count=0;
	scanf("%d %d\n", &n, &k);
	int a[n];
	for (int i = 0; i<n; i++) {
		scanf("%d ", &a[i]);
	}
	for (int i = 0; i<n; i++) {
		if (a[i] > 0 && a[i] >= a[k-1]) {
			count++;
		}
	}
	printf("%d\n", count);
	return 0;
}
