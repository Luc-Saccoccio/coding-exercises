#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DIM 140

typedef struct {
  int value;
  int id;
  bool adjacent;
} cell;

void parse(FILE *file, cell cells[DIM][DIM]) {
  char contents[200];
  int id = 1;

  for (int row = 0; row < DIM; row++) {
    fgets(contents, 200, file);
    for (int col = 0; col < (int)strlen(contents); col++) {
      char c = contents[col];
      if (c != '.') {
        int n = c - '0';
        if (n >= 0 && n < 10) {
          cells[row][col].value = n;
          cells[row][col].id = id;
          id++;
          if (col != 0) {
            cell *prev = &cells[row][col - 1];
            if (prev->value > 0) {
              cells[row][col].value += 10 * prev->value;
              cells[row][col].id = prev->id;
              int offset = 2;
              while (prev->id == cells[row][col].id) {
                prev->value = cells[row][col].value;
                prev = &cells[row][col - offset];
                offset++;
              }
            }
          }
        } else {
          if (!isspace(c)) {
            for (int i = row - 1; i <= row + 1; i++)
              for (int j = col - 1; j <= col + 1; j++)
                cells[i][j].adjacent = true;
            if (c == '*')
              cells[row][col].value = -1;
          }
        }
      }
    }
  }
}

int part_1(cell cells[DIM][DIM]) {
  int total = 0;

  for (int row = 0; row < DIM; row++) {
    int current = 0;
    for (int col = 0; col < DIM; col++) {
      if (cells[row][col].adjacent) {
        int value = cells[row][col].value;
        if (value <= 0) {
          total += current;
          current = 0;
        } else {
          current = value;
          if (col != DIM - 1)
            cells[row][col + 1].adjacent = true;
          else
            total += current;
        }
      }
    }
  }
  return total;
}

int part_2(cell cells[DIM][DIM]) {
  int total = 0;

  for (int row = 0; row < DIM; row++) {
    for (int col = 0; col < DIM; col++) {
      int val = cells[row][col].value;
      if (val == -1) {
        int max_id = 0;
        int gear = 1;
        int count = 0;
        for (int i = row - 1; i <= row + 1; i++) {
          for (int j = col - 1; j <= col + 1; j++) {
            cell adjacent = cells[i][j];
            if (adjacent.id > max_id) {
              max_id = adjacent.id;
              if (adjacent.value > 0 && count <= 2)
                gear *= adjacent.value;
              count++;
            }
          }
        }
        if (count == 2)
          total += gear;
      }
    }
  }
  return total;
}

int main() {
  FILE *file;
  cell cells[DIM][DIM];
  memset(cells, 0, sizeof(cells));

  file = fopen("input.txt", "r");
  parse(file, cells);
  fclose(file);

  printf("(%d,%d)\n", part_1(cells), part_2(cells));
}
