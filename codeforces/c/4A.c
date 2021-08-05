#include<stdio.h>

int main(void) {
	int n;
	scanf("%d\n", &n);
	if (n != 2 && n%2 == 0) {
		printf("YES\n");
	} else {
		printf("NO\n");
	}
	return 0;
}
