#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define MAX 20
#define NUM 4
#define CLASS '#'
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
	int i, old_x, old_y, c, step;
	char space[MAX][MAX];
	char class;

	/*初始化随机数发生器、space数组、spoce结构体数组*/
	srand((unsigned)time(0));
	point spore[NUM];
	memset( spore, 0, sizeof(spore) );
	memset( space, ' ', sizeof(space) );

	for(i = 0; i < NUM; i++)
	     spore[i] = init_point(roll(MAX), roll(MAX));

	/*每个标号每一次扩展一格，遇到空间边框或其他标号则该次停止，等待下次循环。
	 *直到MAX_STEP次循环后停止。						*/
	for(step = 0; step < MAX_STEP; step++) {
		class = CLASS;

		for(i = 0; i < NUM; i++) {
			old_x = spore[i].x;
			old_y = spore[i].y;
			spore[i] = make_point( spore[i], one_step() );

			if ( (c = space[spore[i].x][spore[i].y]) == ' ' || c == class )
				space[spore[i].x][spore[i].y]= class;
			else {
				spore[i].x = old_x;
				spore[i].y = old_y;
			}

			class++;
		}
	}

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

