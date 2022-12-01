#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  char delim = ' ';
  char *s, *token;

  s = malloc(1024 * sizeof(char));
  scanf("%[^\n]", s);
  s = realloc(s, strlen(s) + 1);

  token = strtok(s, &delim);
  printf("%s\n", token);
  while ((token = strtok(NULL, &delim)) != NULL)
    printf("%s\n", token);
  free(s);
  return 0;
}
