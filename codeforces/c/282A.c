#include<stdio.h>

void updateX(char *operation, int* X) {
	switch(operation[0]) {
		case '+':
			(*X)++;
			break;
		case '-':
			(*X)--;
			break;
		default:
			switch(operation[1]) {
				case '+':
					(*X)++;
					break;
				case '-':
					(*X)--;
					break;
			}
	}
}

int main(void) {
	int n, x = 0;
	char operation[4];
	scanf("%d\n", &n);
	for (int i = 0; i<n; i++) {
		scanf("%s\n", operation);
		updateX(operation, &x);
	}
	printf("%d\n", x);
	return 0;
}
