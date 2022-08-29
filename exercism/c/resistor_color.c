#include "resistor_color.h"

const resistor_band_t resistors[] = {BLACK, BROWN, RED,    ORANGE, YELLOW,
                                     GREEN, BLUE,  VIOLET, GREY,   WHITE};

int color_code(resistor_band_t r) {
  return r;
}

const resistor_band_t* colors(void) { return resistors; }
