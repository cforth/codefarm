/*
 __    __       ___      .__   __.   ______    __  
|  |  |  |     /   \     |  \ |  |  /  __  \  |  | 
|  |__|  |    /  ^  \    |   \|  | |  |  |  | |  | 
|   __   |   /  /_\  \   |  . `  | |  |  |  | |  | 
|  |  |  |  /  _____  \  |  |\   | |  `--'  | |  | 
|__|  |__| /__/     \__\ |__| \__|  \______/  |__| 
                                                    
.___________.  ______   ____    __    ____  _______ .______      
|           | /  __  \  \   \  /  \  /   / |   ____||   _  \    
 ---|  |----`|  |  |  |  \   \/    \/   /  |  |__   |  |_)  |    
    |  |     |  |  |  |   \            /   |   __|  |      /     
    |  |     |  `--'  |    \    /\    /    |  |____ |  |\  \----.
    |__|      \______/      \__/  \__/     |_______|| _| `._____|
*/

#include <stdio.h>
#include <malloc.h>
#include <assert.h>
#include <termios.h>
#include <unistd.h>
#define TRUE	1
#define FALSE	0


/*
** 汉诺塔实现与操作
** 
** 使用堆栈来实现汉诺塔。
** 包括动态建立和销毁堆栈，打印堆栈内容，入栈和出栈操作。
** move_hanoi函数旨在实现安全的移塔操作，不会使堆栈溢出。
*/
#define MAX_LEVEL 9
 
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
	for (i = max; i > 0; i--)
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
	for (i = p->length; i > 0; i--)
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
		return FALSE;
	else if ((to->top != to->tower) 
		&& (*(to->top) < *(from->top)))
		return FALSE;

	push_hanoi(to, pop_hanoi(from));
	return TRUE;
}


/*
** 游戏操作与实现
** 
** next_s
** 设定汉诺塔操作起始状态为0号塔。
** 接收当前操作的塔标号now、键盘接收的操作命令c。
** 使用数字标号标示汉诺塔，0号塔、1号塔和2号塔。
** 返回每一次移塔后所在的汉诺塔标号。
*/
int next_s(int now, char c)
{
	int status [3][3] = {/* 'd' 'a' other */
		/*tower 0*/	{ 1, 2, 0 },	
		/*tower 1*/	{ 2, 0, 1 },	
		/*tower 2*/	{ 0, 1, 2 }
	};
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
** display_game
** 接收三个汉诺塔结构体指针。
** 塔的高度l，抓起状态catch，当前操作位置now。
** 打印出游戏图形。
*/
void display_game(Hanoi *x, Hanoi *y, Hanoi *z, int l, int catch, int now, int steps)
{
	int i, j;
	char s;
	char buffer[l][3];

	for (i = 0; i < l; i++)
		for (j = 0; j < 3; j++)
			buffer[i][j] = ' ';
	
	for (i = l - x->length, j = x->length; i < l; i++, j--)
		buffer[i][0] = *(x->tower + j) + '0';
	for (i = l - y->length, j = y->length; i < l; i++, j--)
		buffer[i][1] = *(y->tower + j) + '0';
	for (i = l - z->length, j = z->length; i < l; i++, j--)
		buffer[i][2] = *(z->tower + j) + '0';
	
	printf("\n\t\t\tThe %d LEVEL\n",l);
	printf("\n\t\t\t");
	s = (catch == 1) ? '!' : '*';
	for (j = 0; j < now; j++)
		printf("\t");
	printf("%c\n",s);

	for (i = 0; i < l; i++) {
		printf("\t\t\t");
		for (j = 0; j < 3; j++)
			printf("%c\t",buffer[i][j]);
		printf("\n");
	}
	printf("\t\t\tA\tB\tC\n\n");
	printf("\t\t\tUsed %d steps\n\n\n\n\n\n\n\n", steps);
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
** level_ok
** 接收终点2号塔结构体指针和目标高度。
** 返回当前级别是否已经完成的标志。
**
*/
int level_ok(Hanoi *z, int l)
{
	return (z->length == l) ? TRUE : FALSE;
}


/*
** 主控制结构，测试中。
*/
int main()
{
	char c;
	int level, steps, now, next;
	int catch, moved;
	Hanoi *hanoi[3];

	for (level = 3; level <= MAX_LEVEL; level++) {
		
		hanoi[0] = init_hanoi(level);
		hanoi[1] = init_hanoi(0);
		hanoi[2] = init_hanoi(0);

		steps = 0;
		now = 0;
		catch = FALSE;

		display_game(hanoi[0], hanoi[1], hanoi[2], level, catch, now, steps);
	
		while ((c = my_getch()) != '>') {
	
			moved = FALSE;
			catch = (c == 's') ? !catch : catch;
			next = next_s(now, c);

			if (catch == TRUE) 
				moved = move_hanoi(hanoi[now], hanoi[next]);

			if (moved == TRUE) {
				if (next != now)
					steps++;
			}
			else
				catch = FALSE;

			now = next;

			display_game(hanoi[0], hanoi[1], hanoi[2], level, catch, now, steps);

			if (level_ok(hanoi[2], level) == TRUE) {
				printf("\nEnter any key to next level.\n");
				my_getch();
				break;
			}
		}

		destroy_hanoi(hanoi[0]);
		destroy_hanoi(hanoi[1]);
		destroy_hanoi(hanoi[2]);
	
	}

	return 0;
}
