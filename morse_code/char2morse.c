#include <stdio.h>

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
		printf("  ");
	else
		return -1;
	return 0;
}


int main()
{
	int i, status, c;
	char buff[1000];

	gets(buff);
	for(i = 0; (c = buff[i]) != '\0'; i++) {
		status = char2morse(c);
		printf(" ");
		if (status != 0) {
			printf("\nError! Undefine word: '%c'\n", c);
			break;
		}
	}
	printf("\n");
	return 0;
}
