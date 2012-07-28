#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define MAX 20
#define MAX_STEP 100
typedef struct {
	int x;
	int y;
} point;

int roll( int max_num );
point init_point(int x, int y);
point make_point( point spore, int n );
int one_step( void );
void printf_space( char (*s)[MAX] );

int main( void )
{
	int step;
	char space[MAX][MAX];
	char class = '0';

	/*初始化随机数发生器、space数组、spoce结构体*/
	srand((unsigned)time(0));
	point spore = {MAX/2, MAX/2};
	memset( space, ' ', sizeof(space) );


	/*每个标号每一次随机扩展一格。
	 *执行100步。			*/
	for(step = 0; step < MAX_STEP; step++) {

		spore = make_point( spore, one_step() );

		space[spore.x][spore.y]= class;
		switch(class) {
		case '9': class = 'A'; break;
		case 'Z': class = 'a'; break;
		case 'z': class = '0'; break;
		default : class++;
		}
	}

	/*最后一步用'*'号标明*/
	space[spore.x][spore.y]= '*';
	/*打印整个space数组，显示到屏幕上*/
	printf_space( &space[0] );

	/*打印出总共执行的步数step*/
	printf("Used %d steps.\n", step);
	return 0;
}


/*
** roll
** 返回 0到max_num-1之间的随机整数。
*/
int roll(int max_num)
{
	return rand()%max_num;
}


/*
** init_point
** 初始化ponit，返回point类型结构体。
*/
point init_point(int x, int y)
{
	point temp;
	temp.x = x;
	temp.y = y;
	return temp;
}


/*
** make_point
** 返回数值为下一个坐标位置的point类型结构体。
*/
point make_point( point spore, int n )
{
	int temp_x = spore.x;
	int temp_y = spore.y;

	if(roll(2))
		spore.x += n;
	else
		spore.y += n;
	if((spore.x < 0 || spore.x >= MAX) || (spore.y < 0 || spore.y >= MAX)) {
	      spore.x = temp_x;
	      spore.y = temp_y;
	}

	return spore;
}


/*
** one_step
** 返回 -1到1之间随机整数。
*/
int one_step( void )
{
	return (roll(3) - 1);
}


/*
** printf_space
** 打印整个space数组，显示到屏幕上。
*/
void printf_space( char (*s)[MAX] )
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

