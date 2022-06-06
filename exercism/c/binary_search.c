#include "binary_search.h"

int *binary_search(int value, const int *arr, size_t length) {
  int a = 0;
  int b = length - 1;
  if (length == 0 || arr == NULL)
    return NULL;
  while (a <= b) {
    int c = a + (b - a) / 2;
    if (arr[c] == value)
      return (int *)&arr[c];
    if (arr[c] < value)
      a = c + 1;
    else
      b = c - 1;
  }
  return NULL;
}
