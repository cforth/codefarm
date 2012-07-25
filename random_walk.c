#include <stdio.h>
#define MAX 20
int main( void )
{
	int i, j, point_x, point_y, old_x, old_y;
	char step = '0';
	char plot[MAX][MAX*2];
	point_x = point_y = old_x = old_y = 0;
	srand((unsigned)time(0));
	
	for(i = 0; i < MAX; i++) 
		for(j = 0; j < MAX*2; j++)
			plot[i][j] = ' ';

	for( i = 0; i < MAX/2; i++) {
		if( roll(2) )
			point_x += (roll(3) - 1);
		else 
			point_y += (roll(3) - 1);
		if(point_x != old_x || point_y != old_y)
			step++;
		old_x = point_x;
		old_y = point_y;
		plot[point_y + MAX/2][point_x*2 + MAX] = step;
	}
	
	for(i = 0; i < MAX*2 + 2; i++)
		printf("-");
	printf("\n");
	for(i = 0; i < MAX; i++) {
		printf("|");
		for(j = 0; j < MAX*2; j++)
			printf("%c",plot[i][j]);
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



