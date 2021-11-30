#include <stdio.h>
#include <stdlib.h>

int part1(FILE *in)
{
		int value = 0;
		char c;
		while ((c = fgetc(in)) != '\n')
				value += c == '(' ? : -1;
		return value;
}

int part2(FILE *in)
{
		int floor = 0;
		char c;
		int i = 0;
		for (c = fgetc(in); floor != -1; c = fgetc(in), i++)
				floor += c == '(' ? 1 : -1;
		return i;
}


int main()
{
		FILE *in = fopen("input.txt", "r");

		printf("Part 1: %d\n", part1(in));
		rewind(in);
		printf("Part 2: %d\n", part2(in));
		fclose(in);
		return 0;
}
