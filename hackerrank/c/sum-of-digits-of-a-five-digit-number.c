#include <stdio.h>

int main() {
    int n, res = 0, tmp;
    scanf("%d", &n);
    while (n != 0) {
      tmp = n%10;
      n -= tmp;
      res += tmp;
      n /= 10;
    }
    printf("%d\n", res);
    return 0;
}
