#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define MAX 20
#define NUM 8
#define CLASS '1'
typedef struct {
	int x;
	int y;
} point;

int roll( int max_num );
point init_point(int x, int y);
point make_point( point spore, int n );
int one_step( void );
int is_full( char (*s)[MAX] );

int main( void )
{
	int i, j, old_x, old_y, c, step;
	char space[MAX][MAX];
	char class;

	srand((unsigned)time(0));
	point spore[NUM];
	memset( spore, 0, sizeof(spore) );

	for(i = 0; i < NUM; i++)
	     spore[i] = init_point(roll(MAX), roll(MAX));

	for(i = 0; i < MAX; i++)
	      for(j = 0; j < MAX; j++)
		    space[i][j] = ' ';
	
	for(step = 0; is_full( &space[0] ) == 0; step++) {
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
	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");

	for(i = 0; i < MAX; i++) {
		printf("|");
		for(j = 0; j < MAX; j++)
		      printf("%c ", space[i][j]);
		printf("|\n");
	}

	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");

	/*打印出总共执行的步数step*/
	printf("Used %d steps.\n", step);

	return 0;
}


int roll(int max_num)
{
	return rand()%max_num;
}

point init_point(int x, int y)
{
	point temp;
	temp.x = x;
	temp.y = y;
	return temp;
}

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

int one_step( void )
{
	return (roll(3) - 1);
}

int is_full( char (*s)[MAX] )
{
	int i, j;
	/*测试space数组中是否有空位，有空位返回0，无空位返回1*/
	for(i = 0; i < MAX; i++, s++) {
		for(j = 0; j < MAX; j++) 
			if ((*s)[j] == ' ')
				return 0;
	}
	return 1;
}
