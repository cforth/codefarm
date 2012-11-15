/*
** 将输入复制到输出，将制表符回退符显示出来
*/

#include <stdio.h>

int main()
{
	int c;

	while ((c = getchar()) != EOF) {
		if (c == '\t') {
			putchar('\\');
			putchar('t');
		}
		else if (c == '\b') {
			putchar('\\');
			putchar('b');
		}
		else if (c == '\\') {
			putchar('\\');
			putchar('\\');
		}
		else
			putchar(c);
	}

	return 0;
}
