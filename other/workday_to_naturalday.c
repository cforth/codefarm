/*
** workday_to_naturalday
** 工作日-自然日转换工具
** 周一到周五为工作日
** 设当日为T日，N个工作日等于D个自然日
*/

#include <stdio.h>

int main()
{
	int t, n, d;
	printf("Enter t and n: ");
	scanf("%d %d", &t, &n);
		
	if (t > 7 || t < 1 || n < 0 || n > 10000) {
		printf("error!\n");
		return -1;
	}

	if (t >= 1 && t <= 5) {
		if (n <= 5 - t)
			d = n;
		else
			d = ((n - (5 - t) - 1)/5 + 1) * 2 + n;
	}
	else if (t > 5){
		if (n <= 5)
			d = 7 - t + n;
		else
			d = ((n - 1) / 5) * 2  + 7 - t + n;
	}

	printf("Today is the %d day of the week.\n", t);
	printf("%d working days = %d natural days.\n", n, d);

	return 0;
}
