#include <stdio.h>

int abs(int x)
{
	return (x > 0) ? x : -x;
}

void update(int *a,int *b) {
	int temp = *a;
	*a += *b;
	*b = abs(*b-temp);
}

int main() {
	int a, b;
	int *pa = &a, *pb = &b;

	scanf("%d %d", &a, &b);
	update(pa, pb);
	printf("%d\n%d", a, b);

	return 0;
}
