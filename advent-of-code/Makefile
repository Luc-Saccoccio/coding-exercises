GOAL=haskell
GHC=ghc
GHCFLAGS=-Wall -fprof-auto -fprof-cafs -rtsopts -threaded -O2
CC=cc
CFLAGS=-Wall -Wextra -std=c99 -lm

all: clean ${GOAL} test

haskell:
	${GHC} ${GHCFLAGS} Main.hs -o $@

c:
	${CC} ${CFLAGS} main.c -o $@

ocaml:
	ocamlopt -o $@ main.ml

test: ${GOAL}
	time ./${GOAL}

clean:
	rm -f *.dyn_o *.o *.dyn_hi *.hi *.cmi *.cmx c haskell ocaml
