unsigned long long mystery(unsigned long long n) {
    return n ^ (n >> 1);
}

unsigned long long mystery_inv(unsigned long long n) {
  unsigned long long mask = n >> 1;
  while (mask) {
    n ^= mask;
    mask >>= 1;
  }
  return n;
}

const char* name_of_mystery(void) {
    return "Gray code";
}
