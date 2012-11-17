/*
** 函数实现温度转换表
*/

#include <stdio.h>

float to_fahr(float celsius)
{
	return (celsius * 9.0 / 5.0) + 32.0;
}

int main()
{
	float celsius;

	printf("Celsius\t  Fahr\n");
	for (celsius = 300.0; celsius >= 0.0; celsius = celsius - 20.0)
		printf("%6.0f\t%6.1f\n", celsius, to_fahr(celsius));

	return 0;
}
