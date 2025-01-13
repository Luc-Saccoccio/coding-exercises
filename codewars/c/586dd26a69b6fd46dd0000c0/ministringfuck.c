#include <stdlib.h>

char *my_first_interpreter (const char *code)
{
    int output_len = 64, diff;
    char *output = calloc(output_len, sizeof(char));
    char *current = output;
    unsigned char n = 0;
    while (*code) {
        switch (*code) {
            case '+': n++; break;
            case '.':
                if ((diff = current - output) == (output_len - 1)) {
                    output_len += 64;
                    output = realloc(output, output_len);
                    current = output + diff;
                }
                *current = (char)n;
                current++;
                break;
        }
        code++;
    }
    *(current+1) = 0;
    return output;
}
