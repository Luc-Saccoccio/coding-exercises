#include <stdlib.h>

char *my_first_interpreter (const char *code)
{
    int output_len = 0;
    for (char const* i = code; *i; i++)
        if (*i=='.')
            output_len++;
    char *output = malloc(output_len * sizeof(char));
    char *current = output;
    unsigned char n = 0;
    while (*code) {
        switch (*code) {
            case '+': n++; break;
            case '.': *current++ = (char)n; break;
        }
        code++;
    }
    *current = 0;
    return output;
}
