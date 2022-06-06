#include "collatz_conjecture.h"

int next(int prev) {
  if (prev%2 == 0)
    return prev / 2;
  return 3 * prev + 1;
}

int steps(int start) {
  if (start < 1)
    return ERROR_VALUE;
  int n = 0;
  while (start != 1) {
    start = next(start);
    n++;
  }
  return n;
}
