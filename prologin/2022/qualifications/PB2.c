#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct Piece {
	int cotes;
	char couleur[10];
} Piece;

static int valueinarray(char *value, char arr[][10], int size) {
	for (int i = 0; i < size; i++) {
		if (strcmp(arr[i], value) == 0) {
			return 1;
		}
	}
	return 0;
}

int main(void) {
	int nCouleurs, nCotes, nPieces, n = 0;

	scanf("%d", &nCouleurs);
	char couleurs[nCouleurs][10];
	for (int i = 0; i < nCouleurs; i++)
		scanf("%s", couleurs[i]);

	scanf("%d", &nCotes);
	char couleurscotes[nCotes][10];
	for (int i = 0; i < nCotes; i++)
		scanf("%s", couleurscotes[i]);

	scanf("%d", &nPieces);
	Piece piece;
	for (int i = 0; i < nPieces; i++) {
		scanf("%d", &piece.cotes);
		scanf("%s", piece.couleur);
		if (piece.cotes != nCotes)
			fputc('X', stdout);
		else if (!valueinarray(piece.couleur, couleurscotes, nCotes)) {
			fputc('O', stdout);
			n++;
		} else
			fputc('X', stdout);
	}
	printf("\n%d", n);
	return 0;
}
