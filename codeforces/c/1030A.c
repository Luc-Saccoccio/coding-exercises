#include<stdlib.h>
#include<stdio.h>

int main() {
		int c;
		getchar();
		while ((c = fgetc(stdin)) != EOF)
				if (c == '1') {
						printf("HARD\n");
						return 0;
				}
		printf("EASY\n");
		return 0;
}
