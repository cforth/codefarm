#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<windows.h>


int main()
{
  while(1) {
		printf("Start!Please coin: ");
		int money;
		scanf("%d",&money);
		srand((int)time(0));
		make_lottery(money);   
		printf("\n"); 
	}
	return 0;
}

int make_lottery(int money)
{
	int i;
	int win_num;
	int you_num;
	printf("WinNumber\tYouNumber\n");
	for(i = 0; i < money; i++) {
		you_num = roll();
		win_num = roll();
		printf("%d\t\t%d", win_num, you_num);
		if(you_num == win_num) 
			printf("\tWin!");
		else	printf("\tLose!");
		printf("\n");
		Sleep(1000);		
	}	
	return 0;
}

int roll()
{
	return 1+(int)(10.0*rand()/(RAND_MAX+1.0));
}

