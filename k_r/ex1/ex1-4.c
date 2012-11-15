/*
** 编写一个程序打印摄氏温度转换为华氏温度的转换表
*/

#include <stdio.h>

int main()
{
	float fahr, celsius;
	float lower, upper, step;

	lower = 0;
	upper = 300;
	step = 20;

	printf("Celsius\t  Fahr\n");
	celsius = lower;
	while (celsius <= upper) {
		fahr = (celsius * 9.0 / 5.0) + 32.0;
		printf("%6.0f\t%6.1f\n", celsius, fahr);
		celsius = celsius + step;
	}
	
	return 0;
}
