#include <stdio.h>
#include <string.h>
#define WORDMAX 50

int charcomp(char *x, char *y) 
{
	return *x - *y;
}

int main()
{
	char word[WORDMAX], sign[WORDMAX];
	while (scanf("%s", word) != EOF) {
		strcpy(sign, word);
		qsort(sign, strlen(sign), sizeof(char), charcomp);
		printf("%s %s\n", sign, word);
	}
	return 0;
}
