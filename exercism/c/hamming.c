#include "hamming.h"

int compute(const char *lhs, const char *rhs) {
  int res = 0;
  for (; *lhs && *rhs; lhs++, rhs++)
    if (*lhs != *rhs)
      res++;
  return (*lhs || *rhs) ? -1 : res;
}
