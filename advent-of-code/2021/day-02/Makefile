GOAL=haskell
GHC=ghc
GHCFLAGS=-Wall -Werror -fprof-auto -fprof-cafs -rtsopts -threaded -O2
CC=tcc
CFLAGS=-Wall -Wextra -Werror -std=c99 -lm

all: clean ${GOAL} test

haskell:
	${GHC} ${GHCFLAGS} Main.hs -o $@

c:
	${CC} ${CFLAGS} main.c -o $@

ocaml:
	ocamlopt -o $@ main.ml

test: ${GOAL} input.txt
	./${GOAL}

clean:
	rm -f *.o *.hi *.cmi *.cmx c haskell ocaml
