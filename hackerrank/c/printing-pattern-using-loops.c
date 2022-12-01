#include <stdio.h>
#include <stdlib.h>

int main() {
  int n;
  int i, j;

  scanf("%d", &n);

  int arr[2 * n - 1][2 * n - 1], m = 0;
  while (m <= n) {
    for (i = m; i < ((2 * n) - (m + 1)); i++)
      for (j = m; j < ((2 * n) - (m + 1)); j++)
        arr[i][j] = n - m;
    m++;
  }
  for (i = 0; i < ((2 * n) - 1); i++) {
    for (j = 0; j < ((2 * n) - 1); j++)
      printf("%d ", arr[i][j]);
    printf("\n");
  }
  return 0;
}
