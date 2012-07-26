#include <stdio.h>
#define MAX 20
#define MAX_STEP 5000
typedef struct {
	int x;
	int y;
} point;

int roll( int max_num );
point make_point( point snake, int n );
int one_step( void );

int main( void )
{
	int i, j, step, old_x, old_y;
	char space[MAX][MAX*2];
	point snake_a = {roll(20), roll(20)};
	point snake_b = {roll(20), roll(20)};
	point snake_c = {roll(20), roll(20)};
	point snake_d = {roll(20), roll(20)};
	srand((unsigned)time(0));

	for(i = 0; i < MAX; i++)
	      for(j = 0; j < MAX*2; j++)
		    space[i][j] = ' ';
	
	for(step = 0; step < MAX_STEP; step++) {

		old_x = snake_a.x;
		old_y = snake_a.y;
		snake_a = make_point( snake_a, one_step() ); 
		if ( space[snake_a.x][(snake_a.y)*2] == ' ')
			space[snake_a.x][(snake_a.y)*2]= '1';
		else {
			snake_a.x = old_x;
			snake_a.y = old_y;
		}

		old_x = snake_b.x;
		old_y = snake_b.y;
		snake_b = make_point( snake_b, one_step() ); 
		if ( space[snake_b.x][(snake_b.y)*2] == ' ')
			space[snake_b.x][(snake_b.y)*2]= '2';
		else {
			snake_b.x = old_x;
			snake_b.y = old_y;
		}

		old_x = snake_c.x;
		old_y = snake_c.y;
		snake_c = make_point( snake_c, one_step() ); 
		if ( space[snake_c.x][(snake_c.y)*2] == ' ')
			space[snake_c.x][(snake_c.y)*2]= '3';
		else {
			snake_c.x = old_x;
			snake_c.y = old_y;
		}

		old_x = snake_d.x;
		old_y = snake_d.y;
		snake_d = make_point( snake_d, one_step() ); 
		if ( space[snake_d.x][(snake_d.y)*2] == ' ')
			space[snake_d.x][(snake_d.y)*2]= '4';
		else {
			snake_d.x = old_x;
			snake_d.y = old_y;
		}

	}
	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");

	for(i = 0; i < MAX; i++) {
		printf("|");
		for(j = 0; j < MAX*2; j++)
		      printf("%c", space[i][j]);
		printf("|\n");
	}

	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");

	return 0;
}


int roll(int max_num)
{
	return rand()%max_num;
}

point make_point( point snake, int n )
{
	int temp_x = snake.x;
	int temp_y = snake.y;

	if(roll(2))
		snake.x += n;
	else
		snake.y += n;
	if((snake.x < 0 || snake.x >= MAX) || (snake.y < 0 || snake.y >= MAX)) {
	      snake.x = temp_x;
	      snake.y = temp_y;
	}

	return snake;
}

int one_step( void )
{
	return (roll(3) - 1);
}
