#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAX 20
typedef struct {
	int x;
	int y;
} point;

int roll( int max_num );
point make_point( point spore, int n );
int one_step( void );
int is_full( char (*s)[MAX] );

int main( void )
{
	int i, j, old_x, old_y, c, step;
	char space[MAX][MAX];
	point spore_a = {roll(MAX), roll(MAX)};
	point spore_b = {roll(MAX), roll(MAX)};
	point spore_c = {roll(MAX), roll(MAX)};
	point spore_d = {roll(MAX), roll(MAX)};
	srand((unsigned)time(0));

	for(i = 0; i < MAX; i++)
	      for(j = 0; j < MAX; j++)
		    space[i][j] = ' ';
	
	for(step = 0; is_full( &space[0] ) == 0; step++) {

		/*spore_a执行一步*/
		old_x = spore_a.x;
		old_y = spore_a.y;
		spore_a = make_point( spore_a, one_step() ); 
		if ( (c = space[spore_a.x][spore_a.y]) == ' ' || c == '*' )
			space[spore_a.x][spore_a.y]= '*';
		else {
			spore_a.x = old_x;
			spore_a.y = old_y;
		}

		/*spore_b执行一步*/
		old_x = spore_b.x;
		old_y = spore_b.y;
		spore_b = make_point( spore_b, one_step() ); 
		if ( (c = space[spore_b.x][spore_b.y]) == ' ' || c == '#' )
			space[spore_b.x][spore_b.y]= '#';
		else {
			spore_b.x = old_x;
			spore_b.y = old_y;
		}

		/*spore_c执行一步*/
		old_x = spore_c.x;
		old_y = spore_c.y;
		spore_c = make_point( spore_c, one_step() ); 
		if ( (c = space[spore_c.x][spore_c.y]) == ' ' || c == '@' )
			space[spore_c.x][spore_c.y]= '@';
		else {
			spore_c.x = old_x;
			spore_c.y = old_y;
		}

		/*spore_d执行一步*/
		old_x = spore_d.x;
		old_y = spore_d.y;
		spore_d = make_point( spore_d, one_step() ); 
		if ( (c = space[spore_d.x][spore_d.y]) == ' ' || c == '$' )
			space[spore_d.x][spore_d.y]= '$';
		else {
			spore_d.x = old_x;
			spore_d.y = old_y;
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
