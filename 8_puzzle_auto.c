/*
** 重排九宫,数字推盘游戏
** 自动运行版本
** 将矩阵中的数字按照从小到大排列。
** 数字使用十进制表示：1-9
** 不存在无解的情况。
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <termios.h>
#include <unistd.h>

/* 
** MAX为矩阵边长。
** NUM为矩阵中的数字标号个数，必须是最大个数减1。
** CLASS为起始数字标号。
*/
#define MAX 3
#define NUM 8
#define CLASS '1'
#define MAX_STEP 1000000
#define WIN_NUM 1

/*
** 定义Point类型结构体。
** 用来保存矩阵中单元的横坐标和纵坐标。
*/
typedef struct {
	int x;
	int y;
} Point;

/*
** roll
** 返回 0到max_num-1之间的随机整数。
** 用来确定数字标号在矩阵中的起始位置。
*/
int roll( int max_num );

/*
** printf_matrix
** 打印matrix二维矩阵，显示到屏幕上。
** 用来显示每一次数字标号移动后的矩阵。
*/
void printf_matrix( char (*s)[MAX] );

/*
** is_win
** 矩阵中的数字标号按顺序排列时，返回1， 否则返回0。
** 用来检测矩阵中的数字标号是否已经排列完成。
*/
int is_win( char(*s)[MAX] );

/*
** my_getch
** 功能等同于getch。
** 从键盘立即接受字符，不回显字符，用来操作数字标号移动。
*/
int my_getch( void );

/*
** find_point
** 寻找matrix矩阵中的空格位置，将坐标存入Point类型的结构体返回。
** 用来找出指定矩阵中的空位，确定能够移动的数字标号的位置。
*/
Point find_point( char(*s)[MAX] );

/*
** is_half
** 检测矩阵中第一行和第一列的数字标号排序是否已经完成。
** 用来缩短随机排序的时间。
*/
int is_half( char(*s)[MAX] );


int main( void )
{
	int i, j, c;
	unsigned long step;
	char matrix[MAX][MAX];
	char class;
	int win_num = 0;
	int min = 0;

	/*初始化随机数发生器、matrix矩阵、Site结构体*/
	srand((unsigned)time(0));
	Point Site;
	
	/*初始化矩阵matrix，填入顺序的数字标号*/
	printf("I'm initializing...\n");

	for(i = 0, class = CLASS; i < MAX; i++)
		for(j = 0; j < MAX; j++, class++)
			matrix[i][j]= class;
	matrix[MAX - 1][MAX - 1] = ' ';

	/*随机移动矩阵matrix中的数字标号，作为游戏起始状态*/
	for(step = 0; step < MAX_STEP; step++) {
		c = roll(4);
		Site = find_point( &matrix[0] );
		switch(c) {
		case 0:
			if((Site.y + 1) < MAX) {
				matrix[Site.x][Site.y] = matrix[Site.x][Site.y + 1];
				matrix[Site.x][Site.y + 1] = ' ';
			} break;
		case 1:
			if((Site.y - 1) >= 0) {
				matrix[Site.x][Site.y] = matrix[Site.x][Site.y - 1];
				matrix[Site.x][Site.y - 1] = ' ';
			} break;
		case 2:
			if((Site.x - 1) >= 0) {
				matrix[Site.x][Site.y] = matrix[Site.x - 1][Site.y];
				matrix[Site.x - 1][Site.y] = ' ';
			} break;
		case 3:
			if((Site.x + 1) < MAX) {
				matrix[Site.x][Site.y] = matrix[Site.x + 1][Site.y];
				matrix[Site.x + 1][Site.y] = ' ';
			} break;
		}		
	}
	printf_matrix( &matrix[0] );
	printf("I'm working...\n");

	/*随机移动数字标号，若游戏胜利或者步数超过一百万步则退出，并打印出矩阵*/
	for(step = 0; step < MAX_STEP && win_num != WIN_NUM; step++) {

		c = roll(4);
		Site = find_point( &matrix[0] );

		switch(c) {
		case 0:
			if((Site.y + 1) < MAX) {
				matrix[Site.x][Site.y] = matrix[Site.x][Site.y + 1];
				matrix[Site.x][Site.y + 1] = ' ';
			} break;
		case 1:
			if((Site.y - 1) >= min) {
				matrix[Site.x][Site.y] = matrix[Site.x][Site.y - 1];
				matrix[Site.x][Site.y - 1] = ' ';
			} break;
		case 2:
			if((Site.x - 1) >= min) {
				matrix[Site.x][Site.y] = matrix[Site.x - 1][Site.y];
				matrix[Site.x - 1][Site.y] = ' ';
			} break;
		case 3:
			if((Site.x + 1) < MAX) {
				matrix[Site.x][Site.y] = matrix[Site.x + 1][Site.y];
				matrix[Site.x + 1][Site.y] = ' ';
			} break;
		}		

		switch(min) {
		case 0:
			if(is_half(&matrix[0]) == 1) {
				min += 1;
				printf_matrix( &matrix[0] );
				printf("A half of matrix sorted.\nUsed %lu steps.\n", step);
				break;
			}
		case 1:
			if(is_win(&matrix[0]) == 1) {
				win_num = WIN_NUM;
				break;
			}
		}
	}

	printf_matrix( &matrix[0] );

	/*打印出总共执行的步数step*/
	if(step < MAX_STEP)
		printf("I win!\n");
	else
		printf("I Lost!\n");
	printf("Used %lu steps.\n", step);
	return 0;
}


/*
** roll
*/
int roll( int max_num )
{
	return rand() % max_num;
}


/*
** printf_matrix
*/
void printf_matrix( char (*s)[MAX] )
{
	int i, j;
	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");

	for(i = 0; i < MAX; i++, s++) {
		printf("|");
		for(j = 0; j < MAX; j++)
		      printf("%c ", (*s)[j]);
		printf("|\n");
	}
	
	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");
	return;
}


/*
** is_win
*/
int is_win( char(*s)[MAX] )
{
	int i, j, n;
	char c = CLASS;
	for(i = 0, n = 0; i < MAX; i++, s++)
		for(j = 0; j < MAX && n < NUM; j++, n++, c++)
			if((*s)[j] != c)
				return 0;
	return 1;
}


/*
** my_getch
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
** find_point
*/
Point find_point( char(*s)[MAX] )
{
	Point Temp = {0, 0};
	int i, j;
	for(i = 0; i < MAX; i++, s++) 
		for(j = 0; j < MAX; j++)
			if((*s)[j] == ' ') {
				Temp.x = i;
				Temp.y = j;
				return Temp;
			}
	printf("No space!Error!\n");
	exit(0);
}


/*
** is_half
*/
int is_half( char(*s)[MAX] )
{
	int i;
	char c = CLASS;
	for(i = 0; i < MAX; i++)
		if((*s)[i] != c++)
			return 0;
	s++;
	if((*s)[0] == '4') {
		s++;
		if((*s)[0] == '7')
			return 1;
	}
		
	return 0;
}
