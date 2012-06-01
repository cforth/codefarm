#include <stdio.h>
#include <string.h>
#define WORDMAX 50

int main()
{
	char word[WORDMAX], sig[WORDMAX], oldsig[WORDMAX];
	int linenum = 0;
	strcpy(oldsig, "");
	while (scanf("%s %s", sig, word) != EOF) {
		if(strcmp(oldsig, sig) != 0 && linenum > 0) 
			printf("\n");
		strcpy(oldsig, sig);
		linenum++;
		printf("%s\t\t", word);
	}
	printf("\n");
	return 0;
}
