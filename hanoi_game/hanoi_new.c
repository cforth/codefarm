#include <stdio.h>
#include <malloc.h>
#include <assert.h>

#define MAX_LEVEL 99
 
typedef struct HANOI {
	int tower[MAX_LEVEL];
	int length;
	int *top;
} Hanoi;



Hanoi *init_hanoi(int max)
{
	int i;
	int *p;
	Hanoi *new;

	new = (Hanoi *)malloc(sizeof(Hanoi));
	assert(new != NULL);
	for(i = max, p = new->tower; i > 0; i--, p++)
		*p = i;
	new->length = max;
	new->top = --p;
	
	return new;
}


void printf_hanoi(Hanoi *p)
{
	int i;
	int *temp;

	for(i = p->length, temp = p->tower; i > 0; i--, temp++)
		printf("%d ", *temp);
	printf("\n");
}


void destroy_hanoi(Hanoi *p)
{
	free(p);
}


void push_hanoi(Hanoi *p, int num)
{
	(p->length)++;
	(p->top)++;
	*(p->top) = num;
}


int pop_hanoi(Hanoi *p)
{
	int num = *(p->top);

	(p->top)--;
	(p->length)--;

	return num;
}

void move_hanoi(Hanoi *from, Hanoi *to)
{
	if ((from->length > 0) && (to->length < MAX_LEVEL))
		push_hanoi(to, pop_hanoi(from));
}

int main()
{
	Hanoi *hanoi_a;
	Hanoi *hanoi_b;
	Hanoi *hanoi_c;

	hanoi_a = init_hanoi(5);
	hanoi_b = init_hanoi(0);
	hanoi_c = init_hanoi(0);

	printf_hanoi(hanoi_a);
	printf_hanoi(hanoi_b);
	printf_hanoi(hanoi_c);

	move_hanoi(hanoi_a, hanoi_b);
	move_hanoi(hanoi_c, hanoi_a);
	printf_hanoi(hanoi_a);
	printf_hanoi(hanoi_b);
	printf_hanoi(hanoi_c);

	move_hanoi(hanoi_a, hanoi_c);
	printf_hanoi(hanoi_a);
	printf_hanoi(hanoi_b);
	printf_hanoi(hanoi_c);

	return 0;
}
