/*
** 打印输入中各个字符出现频度的直方图
*/

#include <stdio.h>

int main()
{
	int c, i;
	int nchar[128];

	for (i = 0; i < 128; i++)
		nchar[i] = 0;

	while ((c = getchar()) != EOF) 
		++(nchar[c]);
	
	for (i = 33; i < 127; i++)
		printf("%c:\t%d\n", i, nchar[i]);

	return 0;
}
