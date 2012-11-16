/*
** 将输入中的单词以每行一个打印出来
*/

#include <stdio.h>

#define IN	1
#define OUT	0
#define FIRST 2

int main()
{
	int c, state, old_state;

	old_state = FIRST;

	while ((c = getchar()) != EOF) {
		if (c == ' ' || c == '\n' || c == '\t')
			state = OUT;
		else 
			state = IN;

		if (old_state == OUT && state == IN)
			putchar('\n');

		if (state == IN)
			putchar(c);

		old_state = state;
	}

	return 0;
}
