#include<stdio.h>
#include<stdbool.h>
#include<string.h>

int main(void) {
	int count = 0, i;
	char string[100];
	bool letter[26];
	for (i=0; i<26; i++)
		letter[i] = false;
	scanf("%s\n", string);
	for (i=0; i<strlen(string); i++)
		letter[(int)string[i]-97] = true;
	for (i=0; i<26; i++)
		if (letter[i]) count++;
	printf("%s\n", count%2 == 0 ? "CHAT WITH HER!" : "IGNORE HIM!");
	return 0;
}
