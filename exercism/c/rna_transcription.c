#include "rna_transcription.h"
#include <stdlib.h>
#include <string.h>

static char convert(const char c) {
  switch (c) {
  case 'A': return 'U';
  case 'C': return 'G';
  case 'G': return 'C';
  case 'T': return 'A';
  default: return '\0';
  }
}

char *to_rna(const char *dna) {
  size_t len = strlen(dna) + 1;
  char *rna = (char *)malloc(len * sizeof(char));
  memset(rna, '\0', len);

  for (int i = 0; dna[i]; ++i) {
    rna[i] = convert(dna[i]);
    if (!rna[i]) {
      free(rna);
      return NULL;
    }
  }
  return rna;
}
