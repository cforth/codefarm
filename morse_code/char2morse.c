#include <stdio.h>
#define MAX 1000

static char dict[26][5] =
{
	".-", "-...", "-.-.", "-..", ".",
	"..-.", "--.", "....", "..", ".---",
	"-.-", ".-..", "--", "-.", "---",
	".--.", "--.-", ".-.", "...", "-",
	"..-", "...-", ".--", "-..-", "-.--",
	"--.."
};


int char2morse(int c)
{
	if (c >= 'a' && c <= 'z')
		printf("%s", dict[c - 'a']);
	else if (c == ',')
		printf("--..--");
	else if (c == '.')
		printf(".-.-.-");
	else if (c == '?')
		printf("..--..");
	else if (c == ' ')
		printf("\n");
	else
		return -1;
	return 0;
}


int main()
{
	int i, status, c;
	char buff[MAX];

	fgets(buff, MAX, stdin);
	for(i = 0; (c = buff[i]) != '\n'; i++) {
		printf(" ");
		status = char2morse(c);
		if (status != 0) {
			fprintf(stderr, "\nError! Undefine word: '%c'\n", c);
			break;
		}
	}
	printf("\n");
	return 0;
}
