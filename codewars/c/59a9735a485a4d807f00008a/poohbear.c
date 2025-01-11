#include<stdlib.h>
#include<math.h>
#include<stdio.h>

#define OP_END           0  // End of program
#define OP_INC1_VAL      1  // Add 1 to the current cell
#define OP_DEC1_VAL      2  // Subtract 1 from the current cell
#define OP_INC_DP        3  // Move the cell pointer 1 space to the right
#define OP_DEC_DP        4  // Move the cell pointer 1 space to the left
#define OP_COPY          5  // "Copy" the current cell
#define OP_PASTE         6  // Paste the "copied" cell into the current cell
#define OP_WHILE_START   7  // While loop - While the current cell is not equal to 0
#define OP_WHILE_END     8  // Closing character for loops
#define OP_PRINT_ASCII   9  // Output the current cell's value as ascii
#define OP_PRINT_INT     10  // Output the current cell's value as an integer
#define OP_MULT2_VAL     11 // Multiply the current cell by 2
#define OP_SQUARE_VAL     12 // Square the current cell
#define OP_SQUARE_ROOT_VAL    13 // Square root the current cell's value
#define OP_INC2_VAL      14 // Add 2 to the current cell
#define OP_DEC2_VAL      15 // Subtract 2 from the current cell
#define OP_DIV2_VAL      16 // Divide the current cell by 2
#define OP_ADD_COPIED    17 // Add the copied value to the current cell's value
#define OP_SUB_COPIED    18 // Subtract the copied value from the current cell's value
#define OP_MULT_COPIED   19 // Multiply the current cell's value by the copied value
#define OP_DIV_COPIED    20 // Divide the current cell's value by the copied value.

#define PROGRAM_SIZE     4096
#define OUTPUT_SIZE      1024
#define STACK_SIZE       512

#define STACK_POP()      (STACK[--SP])

struct instruction_t {
    unsigned short operator;
    unsigned short operand;
};

struct cell_t {
    unsigned char value;
    int number;
    struct cell_t *neighbours[2];
};

struct cell_t *new_cell(int n) {
    struct cell_t *cell = malloc(sizeof(struct cell_t));

    cell->neighbours[0] = NULL;
    cell->neighbours[1] = NULL;
    cell->number        = n;
    cell->value         = 0;

    return cell;
}

struct cell_t *goto_cell(int n, struct cell_t* cell) {
    unsigned char k = cell->number < n ? 1 : 0;
    while (cell->number != n) {
        if (cell->neighbours[k] == NULL) {
            cell->neighbours[k] = new_cell(cell->number + ((k << 1) - 1));
            cell->neighbours[k]->neighbours[-k+1] = cell;
        }
        cell = cell->neighbours[k];
    }
    return cell;
}

// Doesn't exist in C99
char *stpcpy(char *restrict d, char *restrict s) {
    for (; (*d=*s); s++, d++);
    return d;
}

struct instruction_t* compile_program(const char* sourcecode) {
    struct instruction_t *program = (struct instruction_t*)malloc(sizeof(struct instruction_t) * PROGRAM_SIZE);
    unsigned short stack[STACK_SIZE];
    unsigned short pc = 0, jmp_pc, sp = 0;
    const char *c = sourcecode;
    while (*c != 0 && pc < PROGRAM_SIZE) {
        switch (*c) {
            case '+': program[pc].operator = OP_INC1_VAL; break;
            case '-': program[pc].operator = OP_DEC1_VAL; break;
            case '>': program[pc].operator = OP_INC_DP; break;
            case '<': program[pc].operator = OP_DEC_DP; break;
            case 'c': program[pc].operator = OP_COPY; break;
            case 'p': program[pc].operator = OP_PASTE; break;
            case 'W':
                program[pc].operator = OP_WHILE_START;
                stack[sp++] = pc;
                break;
            case 'E':
                jmp_pc = stack[--sp];
                program[pc].operator = OP_WHILE_END;
                program[pc].operand  = jmp_pc;
                program[jmp_pc].operand = pc;
                break;
            case 'P': program[pc].operator = OP_PRINT_ASCII; break;
            case 'N': program[pc].operator = OP_PRINT_INT; break;
            case 'T': program[pc].operator = OP_MULT2_VAL; break;
            case 'Q': program[pc].operator = OP_SQUARE_VAL; break;
            case 'U': program[pc].operator = OP_SQUARE_ROOT_VAL; break;
            case 'L': program[pc].operator = OP_INC2_VAL; break;
            case 'I': program[pc].operator = OP_DEC2_VAL; break;
            case 'V': program[pc].operator = OP_DIV2_VAL; break;
            case 'A': program[pc].operator = OP_ADD_COPIED; break;
            case 'B': program[pc].operator = OP_SUB_COPIED; break;
            case 'Y': program[pc].operator = OP_MULT_COPIED; break;
            case 'D': program[pc].operator = OP_DIV_COPIED; break;
            default: pc--;
        }
        pc++;
        c++;
    }

    program[pc].operator = OP_END;
    return program;
}

char *execute_program(struct instruction_t* program) {
    char *output = malloc(sizeof(char) * OUTPUT_SIZE);
    char *start = output;
    *output = 0;
    char *tmp = malloc(sizeof(char) * 8);
    struct cell_t *cell = new_cell(0);
    int copied = 0;
    unsigned short pc = 0;

    while (program[pc].operator != OP_END) {
        switch(program[pc].operator) {
            case OP_INC1_VAL: cell->value++; break;
            case OP_DEC1_VAL: cell->value--; break;
            case OP_INC_DP: cell = goto_cell(cell->number + 1, cell); break;
            case OP_DEC_DP: cell = goto_cell(cell->number - 1, cell); break;
            case OP_COPY: copied = cell->value; break;
            case OP_PASTE: cell->value = copied; break;
            case OP_WHILE_START: if (!(cell->value)) { pc = program[pc].operand; }; break;
            case OP_WHILE_END: if (cell->value) { pc = program[pc].operand; }; break;
            case OP_PRINT_ASCII: *output = cell->value; output++; break;
            case OP_PRINT_INT:
                sprintf(tmp, "%d", cell->value);
                output = (char*)stpcpy(output, tmp);
                break;
            case OP_MULT2_VAL: cell->value *= 2; break;
            case OP_SQUARE_VAL: cell->value *= cell->value; break;
            case OP_SQUARE_ROOT_VAL: cell->value = (int)sqrt((double)cell->value); break;
            case OP_INC2_VAL: cell->value += 2; break;
            case OP_DEC2_VAL: cell->value -= 2; break;
            case OP_DIV2_VAL: cell->value /= 2; break;
            case OP_ADD_COPIED: cell->value += copied; break;
            case OP_SUB_COPIED: cell->value -= copied; break;
            case OP_MULT_COPIED: cell->value *= copied; break;
            case OP_DIV_COPIED: cell->value /= copied; break;
        }
        pc++;
    }

    *output = 0;
    free(tmp);
    return start;
}

char *poohbear (const char* sourcecode) {
    struct instruction_t *program = compile_program(sourcecode);
    char *output = execute_program(program);
    free(program);
    return output;
}
