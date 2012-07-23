#include <stdio.h>

int main( void )
{
	int i;
	int sum_x = 0;
	int sum_y = 0;
	srand((unsigned)time(0));
	
	for( i = 0; i < 10000; i++) {
		if( roll(2) )
			sum_x += (roll(3) - 1);
		else 
			sum_y += (roll(3) - 1);
		printf("Drunk walked to %5d %5d\n", sum_x, sum_y);
	}
	return 0;
}


int roll(int max_num)
{
	return rand()%max_num;
}



