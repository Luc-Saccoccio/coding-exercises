#include <stdio.h>

int main()
{
	int x, y;
	float a, b;
	scanf("%d %d", &x, &y);
	scanf("%f %f", &a, &b);
	printf("%d %d\n%.1f %.1f", x+y, x-y, a+b, a-b);
	return 0;
}
