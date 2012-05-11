#include<stdio.h>
#define TRUE 1
#define FALSE 0
#define MAX 3
#define LENGTH 4
int a_tower[LENGTH], b_tower[LENGTH], c_tower[LENGTH];
int *a_top = &a_tower[MAX], *b_top = b_tower, *c_top = c_tower;
int now_status = 1;
int pointer_status = FALSE;
	
int main()
{
	char c;
	int max_num = MAX;
	init_hanoi(max_num);
	printf("\n\n\n\n\n\n\n\n\n\n");
	show_hanoi();
	
	while(1){
		while(pointer_status == FALSE) {
			c = getch();
			if(c == 'd'){
				switch(now_status) {
					case 1: now_status = 2; break;
					case 2: now_status = 3; break;
					case 3: now_status = 1; break;				
				}
				show_hanoi();
			}
			else if(c == 'a'){
				switch(now_status) {
					case 1: now_status = 3; break;
					case 2: now_status = 1; break;
					case 3: now_status = 2; break;
				}
				show_hanoi();
			}
			else if(c == 's') {
				pointer_status = TRUE;
				show_hanoi();
				break;
			}
		}
	
		while(pointer_status == TRUE) {
			c = getch();		
			if(c == 'd'){
				switch(now_status) {
					case 1: a_to_b(); now_status = 2; break;
					case 2: b_to_c(); now_status = 3; break;
					case 3: c_to_a(); now_status = 1; break;
				}
				show_hanoi();
			}
			else if(c == 'a'){
				switch(now_status) {
					case 1: a_to_c(); now_status = 3; break;
					case 2: b_to_a(); now_status = 1; break;
					case 3: c_to_b(); now_status = 2; break;
				}
				show_hanoi();
			}
			else if(c == 's') {
				pointer_status = FALSE;
				show_hanoi();
				break;
			}
		}
	}
	return 0;	
}

int a_to_b()
{
	if((a_top == &a_tower[0]) || (b_top == &b_tower[MAX]) || (*b_top < *a_top))
		return 0;
	b_top++;
	*b_top = *a_top;
	*a_top = 0;
	a_top--;
	return 0;
}

int a_to_c()
{
	if((a_top == &a_tower[0]) || (c_top == &c_tower[MAX]) || (*c_top < *a_top))
		return 0;
	c_top++;
	*c_top = *a_top;
	*a_top = 0;
	a_top--;
	return 0;
}

int b_to_a()
{
	if((b_top == &b_tower[0]) || (a_top == &a_tower[MAX]) || (*a_top < *b_top))
		return 0;	
	a_top++;
	*a_top = *b_top;
	*b_top = 0;
	b_top--;
	return 0;
}
int b_to_c()
{
	if((b_top == &b_tower[0]) || (c_top == &c_tower[MAX]) || (*c_top < *b_top))
		return 0;
	c_top++;
	*c_top = *b_top;
	*b_top = 0;
	b_top--;
	return 0;
}

int c_to_a()
{
	if((c_top == &c_tower[0]) || (a_top == &a_tower[MAX]) || (*a_top < *c_top))
		return 0;
	a_top++;
	*a_top = *c_top;
	*c_top = 0;
	c_top--;
	return 0;
}

int c_to_b()
{
	if((c_top == &c_tower[0]) || (b_top == &b_tower[MAX]) || (*b_top < *c_top))
		return 0;
	b_top++;
	*b_top = *c_top;
	*c_top = 0;
	c_top--;
	return 0;
}

int show_hanoi()
{
	int i;
	for(i=1; i<now_status; i++)
		printf("\t");
	if(pointer_status == FALSE)
		printf("*\n");
	else
		printf("!\n");
	for(i=MAX; i>0; i--)
		printf("%d\t%d\t%d\n",a_tower[i], b_tower[i], c_tower[i]);
	printf("\n\n\n\n\n\n\n\n\n\n");
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

