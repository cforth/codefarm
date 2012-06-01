#include <stdio.h>

int main()
{
	int c;
	while((c = getchar()) != EOF) {
		if(c >= 'A' && c <= 'Z')
			c += 32;
		printf("%c", c);
	}
}
