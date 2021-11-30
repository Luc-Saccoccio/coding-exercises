.DEFAULT_GOAL := PB3_
CC=tcc
CFLAGS=-Wall -Wextra -Werror -std=c99 -lm
GHC=ghc
GHCFLAGS=-Wall -Werror -fprof-auto -fprof-cafs -rtsopts -threaded -O2

PB1: ## Compile problem 1
	${GHC} ${GHCFLAGS} $@.hs -o $@

PB2: ## Compile problem 2
	${CC} ${CFLAGS} $@.c -o $@

PB3: ## Compile problem 3
	${GHC} ${GHCFLAGS} $@.hs -o $@

PB3_: ## Compile problem 3'
	${GHC} ${GHCFLAGS} $@.hs -o $@

PB4: ## Compile problem 4
	${CC} ${CFLAGS} $@.c -o $@

clean: ## Remove executables and build files
	rm -f PB1{,.hi,.o}
	rm -f PB2
	rm -f PB3{,.hi,.o}
	rm -f PB3_{,.hi,.o}
	rm -f PB4{,.hi,.o}

all: PB1 PB2 PB3 PB4

.PHONY: PB1 PB2 PB3 PB4 clean
