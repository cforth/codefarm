/*
** 逆序打印温度转换表
*/

#include <stdio.h>

int main()
{
	float celsius;

	printf("Celsius\t  Fahr\n");
	for (celsius = 300; celsius >= 0; celsius = celsius - 20)
		printf("%6.0f\t%6.1f\n", celsius, (celsius * 9.0 / 5.0) + 32.0);

	return 0;
}
