/*
** 打印输入中单词长度的直方图
*/

#include <stdio.h>

#define IN	1
#define OUT	0

int main()
{
	int c, i, j, state, old_state, nchar;
	int lword[31];

	for (i = 1; i <= 30; i++)
		lword[i] = 0;

	nchar = 0;
	state = OUT;
	old_state = OUT;

	while ((c = getchar()) != EOF) {

		if ((c >= '0' && c <= '9')
			|| (c >= 'a' && c <= 'z')
			|| (c >= 'A' && c <= 'Z')
			|| c == '\'')
			state = IN;
		else 
			state = OUT;

		if ((old_state == OUT && state == IN)
			|| (old_state == IN && state == IN))
			++nchar;
		else if (old_state == IN && state == OUT) {
			++(lword[nchar]);
			nchar = 0;
		}

		old_state = state;
	}
	
	printf("\nLength	Quantity\n");
	for (i = 1; i <= 30; i++) {
		printf("%6d:\t", i);
		for (j = 1; j <= lword[i]; j++)
			printf("*");
		printf("\n");
	}

	return 0;
}

/*
** 已知的缺陷有，最后一个结尾字符必须是非字母非数字符号。
*/
