#include<stdio.h>
#include<stdlib.h>
#include<termios.h>
#include<unistd.h>
// #include<windows.h>
#define TRUE 1
#define FALSE 0
#define MAX 3
#define ON_A 1
#define ON_B 2
#define ON_C 3

int my_getch( void );
int a_to_b( void );
int a_to_c( void );
int b_to_a( void );
int b_to_c( void );
int c_to_a( void );
int c_to_b( void );
int show_hanoi( void );
int dohanio(int n,int a,int b,int c); 
int init_hanoi(int max_num);

int a_tower[MAX+1], b_tower[MAX+1], c_tower[MAX+1];
int *a_top = &a_tower[MAX], *b_top = b_tower, *c_top = c_tower;
int now_status = ON_A;
int catch_status = FALSE;
	
int main()
{
	char c;
	int max_num = MAX;
	init_hanoi(max_num);
	printf("\n\n\n\n\n\n\n");
	printf("\t\tHanio Game\n\t\tEnter '<' to quit!Enter '>' to show cheats!\n\n");
	show_hanoi();
	
	while(1){
		while(catch_status == FALSE) {
			c = my_getch();
//			Sleep(100);
			if(c == 'd'){
				switch(now_status) {
					case ON_A: now_status = ON_B; break;
					case ON_B: now_status = ON_C; break;
					case ON_C: now_status = ON_A; break;				
				}
				show_hanoi();
			}
			else if(c == 'a'){
				switch(now_status) {
					case ON_A: now_status = ON_C; break;
					case ON_B: now_status = ON_A; break;
					case ON_C: now_status = ON_B; break;
				}
				show_hanoi();
			}
			else if(c == 's') {
				catch_status = TRUE;
				show_hanoi();
				break;
			}
			else if(c == '>') {
				dohanio(max_num,65,66,67);
				printf("\n\n\n\n\n\n\n\n");
				break;
			}
			else if(c == '<') {
				printf("Good Game! Bye!\n");
				exit(0);
			}
		}
	
		while(catch_status == TRUE) {
			c = my_getch();
//			Sleep(100);
			if(c == 'd'){
				switch(now_status) {
					case ON_A: a_to_b(); now_status = ON_B; break;
					case ON_B: b_to_c(); now_status = ON_C; break;
					case ON_C: c_to_a(); now_status = ON_A; break;
				}
				show_hanoi();
			}
			else if(c == 'a'){
				switch(now_status) {
					case ON_A: a_to_c(); now_status = ON_C; break;
					case ON_B: b_to_a(); now_status = ON_A; break;
					case ON_C: c_to_b(); now_status = ON_B; break;
				}
				show_hanoi();
			}
			else if(c == 's') {
				catch_status = FALSE;
				show_hanoi();
				break;
			}
			else if(c == '>') {
				dohanio(max_num,65,66,67);
				printf("\n\n\n\n\n\n\n\n");
				break;
			}
			else if(c == '<') {
				printf("Good Game! Bye!\n");
				exit(0);
			}
			
		}

	}
	return 0;	
}

int a_to_b()
{
	if((a_top == &a_tower[0]) || (b_top == &b_tower[MAX]) || (*b_top < *a_top)) {
		catch_status = FALSE;
		return 0;
	}
	b_top++;
	*b_top = *a_top;
	*a_top = 0;
	a_top--;
	return 0;
}

int a_to_c()
{
	if((a_top == &a_tower[0]) || (c_top == &c_tower[MAX]) || (*c_top < *a_top)) {
		catch_status = FALSE;
		return 0;
	}
	c_top++;
	*c_top = *a_top;
	*a_top = 0;
	a_top--;
	return 0;
}

int b_to_a()
{
	if((b_top == &b_tower[0]) || (a_top == &a_tower[MAX]) || (*a_top < *b_top)) {
		catch_status = FALSE;
		return 0;
	}
	a_top++;
	*a_top = *b_top;
	*b_top = 0;
	b_top--;
	return 0;
}
int b_to_c()
{
	if((b_top == &b_tower[0]) || (c_top == &c_tower[MAX]) || (*c_top < *b_top)) {
		catch_status = FALSE;
		return 0;
	}
	c_top++;
	*c_top = *b_top;
	*b_top = 0;
	b_top--;
	return 0;
}

int c_to_a()
{
	if((c_top == &c_tower[0]) || (a_top == &a_tower[MAX]) || (*a_top < *c_top)) {
		catch_status = FALSE;
		return 0;
	}
	a_top++;
	*a_top = *c_top;
	*c_top = 0;
	c_top--;
	return 0;
}

int c_to_b()
{
	if((c_top == &c_tower[0]) || (b_top == &b_tower[MAX]) || (*b_top < *c_top)) {
		catch_status = FALSE;
		return 0;
	}
	b_top++;
	*b_top = *c_top;
	*c_top = 0;
	c_top--;
	return 0;
}

int show_hanoi()
{
	int i;
//	printf("\t\t\t\t------Hanoi------\n");
	for(i=1; i<now_status; i++)
		printf("\t");
	if(catch_status == FALSE)
		printf("\t\t\t\t*\n");
	else
		printf("\t\t\t\t!\n");
	for(i=MAX; i>0; i--)
		printf("\t\t\t\t%d\t%d\t%d\n",a_tower[i], b_tower[i], c_tower[i]);
	printf("\t\t\t\tA\tB\tC");
	printf("\n\n\n\n\n\n\n\n\n\n\n");
	return 0;
}

int init_hanoi(int max_num)
{
	int i;
	for(i=1; i<=MAX; i++,max_num--)
		a_tower[i] = max_num;
	a_tower[0] = b_tower[0] = c_tower[0] = 100;
	return 0;
}

int  dohanio(int n,int a,int b,int c) 
{
	if(n==1)
		printf("%c->%c ",a,c);      
	else    {
		dohanio(n-1,a,c,b);                     
		printf("%c->%c ",a,c);         
		dohanio(n-1,b,a,c);   
	} 
	return 0;
} 



int my_getch(void)
{
struct termios oldt,
newt;
int ch;
tcgetattr( STDIN_FILENO, &oldt );
newt = oldt;
newt.c_lflag &= ~( ICANON | ECHO );
tcsetattr( STDIN_FILENO, TCSANOW, &newt );
ch = getchar();
tcsetattr( STDIN_FILENO, TCSANOW, &oldt );
return ch;
}
