/*
** 将输入复制到输出，并将连续多个空格用一个空格代替
*/

#include <stdio.h>

int main()
{
	int c, ns;

	ns = 0;
	while ((c = getchar()) != EOF) {
		if (c == ' ')
			++ns;
		else
			ns = 0;

		if (ns < 2)
			putchar(c);
	}

	return 0;
}
