#include <stdio.h>
#include <malloc.h>
#include <assert.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>

/*
** 汉诺塔模块
** 使用堆栈来实现汉诺塔。
** 包括动态建立和销毁堆栈，打印堆栈内容，入栈和出栈操作。
** move_hanoi函数旨在实现安全的移塔操作，不会使堆栈溢出。
*/
#define MAX_LEVEL 99
 
typedef struct HANOI {
	int tower[MAX_LEVEL+1];
	int length;
	int *top;
} Hanoi;



Hanoi *init_hanoi(int max)
{
	int i;
	int *temp;
	Hanoi *new;

	new = (Hanoi *)malloc(sizeof(Hanoi));
	assert(new != NULL);
	temp = new->tower;
	for(i = max; i > 0; i--)
		*(++temp) = i;
	new->length = max;
	new->top = temp;
	
	return new;
}


void printf_hanoi(Hanoi *p)
{
	int i;
	int *temp;
	
	temp = p->tower;
	for(i = p->length; i > 0; i--)
		printf("%d ", *(++temp));
	printf("\n");
}


void destroy_hanoi(Hanoi *p)
{
	free(p);
}


void push_hanoi(Hanoi *p, int num)
{
	(p->length)++;
	(p->top)++;
	*(p->top) = num;
}


int pop_hanoi(Hanoi *p)
{
	int num = *(p->top);

	(p->top)--;
	(p->length)--;

	return num;
}


int move_hanoi(Hanoi *from, Hanoi *to)
{
	if ((from->length <= 0) 
		|| (to->length >= MAX_LEVEL))
		return 0;
	else if ((to->top != to->tower) 
		&& (*(to->top) < *(from->top)))
		return 0;

	push_hanoi(to, pop_hanoi(from));
	return 1;
}


/*
** 状态机模块
** 设定汉诺塔操作起始状态为0号塔。
** 返回每一次移塔后所在的汉诺塔标号。
** 使用数字标号标示汉诺塔，0号塔、1号塔和2号塔。
*/
int status [3][3] = {/* 'd' 'a' other */
	/*tower 0*/			{ 1, 2, 0 },	
	/*tower 1*/			{ 2, 0, 1 },	
	/*tower 2*/			{ 0, 1, 2 }
};


int next_s(int now, char c)
{
	int i;
	if (c == 'd')
		i = 0;
	else if (c == 'a')
		i = 1;
	else
		i = 2;

	return status[now][i]; 
}


/*
** my_getch
** 实现无回显的立即返回键盘输入的函数。
*/
int my_getch(void)
{
	struct termios oldt,
	newt;
	int ch;
	tcgetattr( STDIN_FILENO, &oldt );
	newt = oldt;
	newt.c_lflag &= ~( ICANON | ECHO );
	tcsetattr( STDIN_FILENO, TCSANOW, &newt );
	ch = getchar();
	tcsetattr( STDIN_FILENO, TCSANOW, &oldt );
	return ch;
}


/*
** 主控制结构，测试中。
*/
int main()
{
	Hanoi *hanoi[3];
	hanoi[0] = init_hanoi(3);
	hanoi[1] = init_hanoi(0);
	hanoi[2] = init_hanoi(0);

	int i;
	int now = 0;
	int catch = 0;
	
	for (i = 0; i < 3; i++)
		printf_hanoi(hanoi[i]);
	printf("now = %d\ncatch = %d\n\n", now, catch);

	char c;
	int next, ifmove;
	
	while ((c = my_getch()) != '>') {

		catch = (c == 's') ? !catch : catch;
		next = next_s(now, c);

		if(catch == 1) {
			ifmove = move_hanoi(hanoi[now], hanoi[next]);
			catch = (ifmove == 0) ? 0 : 1;
			}
		else 
			catch = 0;

		now = next;

		for (i = 0; i < 3; i++)
			printf_hanoi(hanoi[i]);
		printf("now = %d\ncatch = %d\n\n", now, catch);
	}

	return 0;
}
