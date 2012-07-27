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

int main( void )
{
	int i, j, old_x, old_y, c;
	int step = 0;
	int is_full = 0;
	char space[MAX][MAX*2];
	point spore_a = {roll(MAX), roll(MAX)};
	point spore_b = {roll(MAX), roll(MAX)};
	point spore_c = {roll(MAX), roll(MAX)};
	point spore_d = {roll(MAX), roll(MAX)};
	srand((unsigned)time(0));

	for(i = 0; i < MAX; i++)
	      for(j = 0; j < MAX*2; j++)
		    space[i][j] = ' ';
	
	while(!is_full) {

		old_x = spore_a.x;
		old_y = spore_a.y;
		spore_a = make_point( spore_a, one_step() ); 
		if ( (c = space[spore_a.x][(spore_a.y)*2]) == ' ' || c == '*' )
			space[spore_a.x][(spore_a.y)*2]= '*';
		else {
			spore_a.x = old_x;
			spore_a.y = old_y;
		}

		old_x = spore_b.x;
		old_y = spore_b.y;
		spore_b = make_point( spore_b, one_step() ); 
		if ( (c = space[spore_b.x][(spore_b.y)*2]) == ' ' || c == '#' )
			space[spore_b.x][(spore_b.y)*2]= '#';
		else {
			spore_b.x = old_x;
			spore_b.y = old_y;
		}

		old_x = spore_c.x;
		old_y = spore_c.y;
		spore_c = make_point( spore_c, one_step() ); 
		if ( (c = space[spore_c.x][(spore_c.y)*2]) == ' ' || c == '@' )
			space[spore_c.x][(spore_c.y)*2]= '@';
		else {
			spore_c.x = old_x;
			spore_c.y = old_y;
		}

		old_x = spore_d.x;
		old_y = spore_d.y;
		spore_d = make_point( spore_d, one_step() ); 
		if ( (c = space[spore_d.x][(spore_d.y)*2]) == ' ' || c == '$' )
			space[spore_d.x][(spore_d.y)*2]= '$';
		else {
			spore_d.x = old_x;
			spore_d.y = old_y;
		}
		
		step++;

		is_full = 1;
		for(i = 0; i < MAX; i++) { 
	    	for(j = 0; j < MAX*2; j+=2)
		    	if (space[i][j] == ' ') {
					is_full = 0;
					break;
				}
			if(is_full == 0)
				break;
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
