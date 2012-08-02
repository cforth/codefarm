/*
** 重排九宫，自动运行版本。
** 数字推盘游戏，将矩阵中的数字按照从小到大排列。
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

/* MAX为矩阵边长。
** NUM为矩阵中的数字标号个数，必须是最大个数减1。
** CLASS为起始数字标号。
*/
#define MAX 3
#define NUM 8
#define CLASS '1'
#define WIN_NUM 1
#define MAX_STEP 999999

/* 定义point类型结构体。
** 用来保存矩阵中单元的横坐标和纵坐标。
*/
typedef struct {
	int x;
	int y;
} point;

/*
** roll
** 返回 0到max_num-1之间的随机整数。
** 用来确定数字标号在矩阵中的起始位置。
*/
int roll( int max_num );

/*
** init_point
** 初始化point，返回point类型结构体。
** 用来给结构体赋值, 初始化矩阵的起始状态。
*/
point init_point(int x, int y);

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
** find_point
** 寻找matrix矩阵中的空格位置，将坐标存入point类型的结构体返回。
** 用来找出指定矩阵中的空位，确定能够移动的数字标号的位置。
*/
point find_point( char(*s)[MAX] );

/*
** is_half
** 检测矩阵中第一行和第一列的数字标号排序是否已经完成。
** 用来缩短随机排序的时间。
*/
int is_half( char(*s)[MAX] );


int main( void )
{
	int i, c;
	unsigned long step;
	char matrix[MAX][MAX];
	char class;
	int min = 0;
	int win_num = 0;

	/*初始化随机数发生器、matrix矩阵、spoce结构体数组*/
	srand((unsigned)time(0));
	point spore[NUM];
	point site;
	memset( spore, 0, sizeof(spore) );
	memset( matrix, ' ', sizeof(matrix) );
	
	/*初始化数字标号随机乱序的矩阵matrix*/
	printf("I'm initializing...\n");

	for(i = 0, class = CLASS; i < NUM; i++, class++) {
		spore[i] = init_point(roll(MAX), roll(MAX));
		
		while(matrix[spore[i].x][spore[i].y] != ' ')
			spore[i] = init_point(roll(MAX), roll(MAX));
		
		matrix[spore[i].x][spore[i].y]= class;
		
	}

	printf_matrix( &matrix[0] );
	printf("I'm working...\n");

	/*随机移动数字标号，若游戏胜利或者步数超过一百万步则退出，并打印出矩阵*/
	for(step = 0; step <= MAX_STEP && win_num != WIN_NUM; step++) {

		c = roll(4);
		site = find_point( &matrix[0] );

		switch(c) {
		case 0:
			if((site.y + 1) < MAX) {
				matrix[site.x][site.y] = matrix[site.x][site.y + 1];
				matrix[site.x][site.y + 1] = ' ';
			} break;
		case 1:
			if((site.y - 1) >= min) {
				matrix[site.x][site.y] = matrix[site.x][site.y - 1];
				matrix[site.x][site.y - 1] = ' ';
			} break;
		case 2:
			if((site.x - 1) >= min) {
				matrix[site.x][site.y] = matrix[site.x - 1][site.y];
				matrix[site.x - 1][site.y] = ' ';
			} break;
		case 3:
			if((site.x + 1) < MAX) {
				matrix[site.x][site.y] = matrix[site.x + 1][site.y];
				matrix[site.x + 1][site.y] = ' ';
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
	if(step > MAX_STEP ) {
		printf("I lost!\n");
		printf("Used %lu steps.\n", step);
	}
	else {
		printf("I win!\n");
		printf("Used %lu steps.\n", step);
	}	
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
** init_point
*/
point init_point( int x, int y )
{
	point temp;
	temp.x = x;
	temp.y = y;
	return temp;
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
		for(j = 0; j < MAX && n < NUM; j++, n++)
			if((*s)[j] != c++)
				return 0;
	return 1;
}



/*
** find_point
*/
point find_point( char(*s)[MAX] )
{
	point temp = {0, 0};
	int i, j;
	for(i = 0; i < MAX; i++, s++) 
		for(j = 0; j < MAX; j++)
			if((*s)[j] == ' ') {
				temp.x = i;
				temp.y = j;
				return temp;
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
