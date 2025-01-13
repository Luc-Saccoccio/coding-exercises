#include <stddef.h>
#include <stdlib.h>
#include <string.h>

enum inst_type {
    INST_MOV,
    INST_INC,
    INST_DEC,
    INST_JNZ
};

enum arg_type {
    ARG_REG,
    ARG_INT
};

struct arg_t {
    enum arg_type type;
    int content;
};


struct command_t {
    enum inst_type type;
    struct arg_t *arg1;
    struct arg_t *arg2;
};

struct command_t* translate(size_t n, const char *const program[n])
{
    struct command_t *commands = (struct command_t*)malloc(n * sizeof(struct command_t));
    struct command_t *commands_ptr = commands;
    char *saveptr, *token;
    char *instruction = malloc(64 * sizeof(char));
    for (size_t i = 0; i < n; i++, commands_ptr++) {
        switch (*(program[i])) {
            case 'i':
                commands_ptr->type = INST_INC;
                commands_ptr->arg1 = (struct arg_t*)malloc(sizeof(struct arg_t));
                commands_ptr->arg2 = NULL;
                commands_ptr->arg1->type = ARG_REG;
                commands_ptr->arg1->content = *(program[i]+4);
                break;
            case 'd':
                commands_ptr->type = INST_DEC;
                commands_ptr->arg1 = (struct arg_t*)malloc(sizeof(struct arg_t));
                commands_ptr->arg2 = NULL;
                commands_ptr->arg1->type = ARG_REG;
                commands_ptr->arg1->content = *(program[i]+4);
                break;
            case 'm':
                commands_ptr->type = INST_MOV;
                commands_ptr->arg1 = (struct arg_t*)malloc(sizeof(struct arg_t));
                commands_ptr->arg1->type = ARG_REG;
                commands_ptr->arg1->content = *(program[i]+4);
                commands_ptr->arg2 = (struct arg_t*)malloc(sizeof(struct arg_t));
                if (program[i][6] > 96) {
                    commands_ptr->arg2->type = ARG_REG;
                    commands_ptr->arg2->content = *(program[i]+6);
                } else {
                    commands_ptr->arg2->type = ARG_INT;
                    commands_ptr->arg2->content = atoi(program[i]+6);
                }
                break;
            case 'j':
                commands_ptr->type = INST_JNZ;
                commands_ptr->arg1 = (struct arg_t*)malloc(sizeof(struct arg_t));
                commands_ptr->arg2 = (struct arg_t*)malloc(sizeof(struct arg_t));
                saveptr = NULL;
                instruction = strcpy(instruction, program[i]+4);
                token = strtok_r(instruction, " ", &saveptr);
                if (*token > 96) {
                    commands_ptr->arg1->type = ARG_REG;
                    commands_ptr->arg1->content = *token;
                } else {
                    commands_ptr->arg1->type = ARG_INT;
                    commands_ptr->arg1->content = atoi(token);
                }
                token = strtok_r(NULL, " ", &saveptr);
                if (*token > 96) {
                    commands_ptr->arg2->type = ARG_REG;
                    commands_ptr->arg2->content = *token;
                } else {
                    commands_ptr->arg2->type = ARG_INT;
                    commands_ptr->arg2->content = atoi(token);
                }
                break;
        }
    }
    free(instruction);
    return commands;
}

void free_commands(size_t n, struct command_t commands[n]) {
    for (size_t i = 0; i < n; i++) {
        free(commands[i].arg1);
        free(commands[i].arg2);
    }
    free(commands);
}

void simple_assembler(size_t n, const char* const program[n], int registers[])
{
    struct command_t *commands = translate(n, program);
    size_t i = 0;
    while (i < n) {
        switch (commands[i].type) {
            case INST_MOV:
                if (commands[i].arg2->type)
                    registers[commands[i].arg1->content] = commands[i].arg2->content;
                else
                    registers[commands[i].arg1->content] = registers[commands[i].arg2->content];
                break;
            case INST_INC:
                registers[commands[i].arg1->content]++;
                break;
            case INST_DEC:
                registers[commands[i].arg1->content]--;
                break;
            case INST_JNZ:
                if (commands[i].arg1->type) {
                    if (commands[i].arg1->content) {
                        if (commands[i].arg2->type)
                            i += commands[i].arg2->content - 1;
                        else
                            i += registers[commands[i].arg2->content] - 1;
                    }
                } else if (registers[commands[i].arg1->content]) {
                        if (commands[i].arg2->type)
                            i += commands[i].arg2->content - 1;
                        else
                            i += registers[commands[i].arg2->content] - 1;
                }
                break;
        }
        i++;
    }
    free_commands(n, commands);
}
