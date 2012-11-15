/*
** 在printf函数的参数字符串中包含\c
** c是转义字符序列中未出现的某一个字符
*/

#include <stdio.h>

main()
{
	printf("Hello \cWorld!\n");
}


/*
** 结果中会显示出字符‘c’
*/
