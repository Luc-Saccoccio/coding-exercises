#include<stdio.h>
#include<string.h>

void process(char string[]) {
	int l = strlen(string);
	if (l > 10)
		printf("%c%d%c\n", string[0], l-2, string[l-1]);
	else
		printf("%s\n", string);
}

int main(void) {
	int n;
	char string[100];
	scanf("%d\n", &n);
	for (int i=0; i<n; i++) {
		scanf("%s\n", string);
		process(string);
	}
	return 0;
}
