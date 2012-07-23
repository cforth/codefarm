#include <stdio.h>
#include <stdlib.h>

#define MAX 3
#define YOUR 5
int is_single( int num );
int roll ( int max_num );
int find_num( int* your_num, int* win_num );

int main( void )
{
	int num, i, c, win_num[MAX], your_num[YOUR];
	srand((unsigned)time(0));

	printf("Enter five numbers: ");
	for(i = 0; i < YOUR; i++) {
		scanf("%d", &num);
		if( !is_single(num) ) {
			printf("Please enter number between 0 and 9!\n");
			return -1;
		}
		your_num[i] = num;
	}

	for(i = 0; i < MAX; i++)
			win_num[i] = roll(10);
	
	printf("\nYour numbers:\t");
	for(i = 0; i < YOUR; i++) 
		printf("%d ", your_num[i]);

	printf("\nWin numbers:\t");
	for(i = 0; i < MAX; i++) 
		printf("%d ", win_num[i]);
	
	printf("\nGet %d number!\n", find_num(your_num, win_num));

	printf("Enter any key to quit!\n");
	while((c = getchar()) != '\n' && c != EOF);
	getchar();
	return 0;
}

int is_single( int num )
{
	return (num <= 9 && num >= 0);
}

int roll(int max_num)
{
	return rand()%max_num;
}

int find_num( int* your_num, int* win_num )
{
	int i, j;
	int num = 0;
	for( i = 0; i < YOUR; i++ ) 
		for( j = 0; j < MAX; j++) 
			if(*(your_num + i) == *(win_num + j)) {
				*(win_num + j) = -1;
				num ++;
				break;
			}
	return num;
}
