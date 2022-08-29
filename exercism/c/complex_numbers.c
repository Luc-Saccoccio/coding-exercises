#include "complex_numbers.h"
#include <math.h>

static double square(double x) { return x * x; }

complex_t c_add(complex_t a, complex_t b) {
  complex_t z = {.real = a.real + b.real, .imag = a.imag + b.imag};
  return z;
}

complex_t c_sub(complex_t a, complex_t b)
{
  complex_t z = {.real = a.real - b.real, .imag = a.imag - b.imag};
  return z;
}

complex_t c_mul(complex_t a, complex_t b) {
  complex_t z = {.real = a.real * b.real - a.imag * b.imag,
                 .imag = a.real * b.imag + a.imag * b.real};
  return z;
}

complex_t c_div(complex_t a, complex_t b) {
  double d = square(b.real) + square(b.imag);
  complex_t res = {.real = (a.real * b.real + a.imag * b.imag) / d,
                   .imag = (a.imag * b.real - a.real * b.imag) / d};
  return res;
}

double c_abs(complex_t x)
{
   return sqrt(square(x.real) + square(x.imag));
}

complex_t c_conjugate(complex_t x)
{
  complex_t z = { .real = x.real, .imag = - x.imag };
  return z;
}

double c_real(complex_t x)
{
   return x.real;
}

double c_imag(complex_t x)
{
   return x.imag;
}

complex_t c_exp(complex_t x) {
  double r = exp(x.real);
  complex_t res = {.real = r * cos(x.imag), .imag = r * sin(x.imag)};
  return res;
}
