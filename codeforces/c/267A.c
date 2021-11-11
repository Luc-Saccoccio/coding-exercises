#include<stdio.h>
int main(void) {
	int n, a, b, c;
	scanf("%d\n", &n);
	for (int i = 0; i<n; i++) {
		scanf("%d %d\n", &a, &b);
		for (c = 0; a != 0 && b != 0; ) {
			if (a>b) {
				c += a/b;
				a = a%b;
			} else {
				c += b/a;
				b%=a;
			}
		}
		printf("%d\n", c);
	}
	return 0;
}
