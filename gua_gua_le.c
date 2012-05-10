#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<windows.h>
const int award[10] = {5,10,15,20,30,50,100,500,1000,10000};
static int prize_pool[10000];
static int sum = 0;

int main()
{
	generate_prize_pool();
//	look_prize_pool();
	while(1) {
		printf("Start!Please coin: ");
		int money;
		scanf("%d",&money);
		srand((int)time(0));
		make_lottery(money);   
		printf("\n"); 
		printf("You win %d yuan!!!\n",sum);
		sum = 0;
	}
	return 0;
}

int make_lottery(int money)
{
	int i;
	int win_num;
	int you_num;
	int award_money;
	int max_num = 10;
	
	
	printf("WinNumber\tYouNumber\tAwardMoney\n");
	for(i = 0; i < money; i++) {
		you_num = roll(max_num);
		win_num = roll(max_num);
		
		printf("%d\t\t%d\t\t", win_num, you_num);
		if(you_num == win_num) {
			award_money = prize_pool[roll(10000)];
			sum += award_money;
			printf("%d\tWin!",award_money);
		}
		else {
			award_money = award[roll(10) - 1];
			printf("%d\tLose!",award_money);
		}
		printf("\n");
//		Sleep(1000);		
	}	
	return 0;
}

int roll(int max_num)
{
	return 1+(int)(max_num*rand()/(RAND_MAX+1.0));
}

int generate_prize_pool()
{
	int i,j,k,temp;
	
	int award_num[10] = {7370,1000,666,500,333,200,100,20,10,1};
	
	for(i=0; i<10000; i++)
		prize_pool[i] = 5;
	for(j=0; j<10; j++)
		for(k=0; k<award_num[j]; k++){
			temp = roll(10000);
			prize_pool[temp] = award[j];
		}
	return 0;	
}

int look_prize_pool()
{
	int i;
	for(i=0; i<10000; i++)
		printf("%d ",prize_pool[i]);
	printf("\n");
	return 0;
}
