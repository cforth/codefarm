/*
** 统计空格、制表符与换行符个数
*/

#include <stdio.h>

int main()
{
	int c, ns, nt, nl;

	ns = 0;
	nt = 0;
	nl = 0;
	while ((c = getchar()) != EOF) {
		if (c == ' ')
			++ns;
		else if (c == '\t')
			++nt;
		else if (c == '\n')
			++nl;
	}
	printf("Spaces:%d\nTabs:%d\nLines:%d\n", ns, nt, nl);

	return 0;
}
