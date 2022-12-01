#include <stdio.h>

void calculate_the_maximum(int n, int k) {
  int max_and = 0, max_or = 0, max_xor = 0;
  for (int i = 1; i <= n; i++)
    for (int j = i + 1; j <= n; j++) {
      if (max_and < (i & j) && (i & j) < k)
        max_and = i & j;
      if (max_or < (i | j) && (i | j) < k)
        max_or = i | j;
      if (max_xor < (i ^ j) && (i ^ j) < k)
        max_xor = i ^ j;
    }
  printf("%d\n%d\n%d\n", max_and, max_or, max_xor);
}

int main() {
  int n, k;

  scanf("%d %d", &n, &k);
  calculate_the_maximum(n, k);

  return 0;
}
