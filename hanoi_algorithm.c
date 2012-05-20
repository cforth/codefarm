#include<stdio.h>

int main()
{
	int i,n,num;
	int jie[1000]={1,2,1,3,2,3,1,2,3,1,3,2,1,2,1,3,2,3,2,1,3,1,2,3,1,2,1,3,2,3,1,2,3,1,3,2,1,2,3,1,2,3,2,1,3,1,3,2,1,2,1,3,2,3,1,2,3,1,3,2,1,2,1,3,2,3,2,1,3,1,2,3,1,2,1,3,2,3,2,1,3,1,3,2,1,2,3,1,2,3,2,1,3,1,2,3,1,2,1,3,2,3,1,2,3,1,3,2,1,2,1,3,2,3,2,1,3,1,2,3,1,2,1,3,2,3};
	char change[1000];
	num = 2;
	for(i=0,n=0; jie[i] != 0; i++) {
		if(num%2 == 0) {
			if(jie[i] == 1 && jie[i+1] == 2) {
				change[n++] = 's';
				change[n++] = 'd';
				change[n++] = 's';
			}
			else if(jie[i] == 1 && jie[i+1] == 3) {
				change[n++] = 's';
				change[n++] = 'a';
				change[n++] = 's';
			}
			else if(jie[i] == 2 && jie[i+1] == 1) {
				change[n++] = 's';
				change[n++] = 'a';
				change[n++] = 's';
			}
			else if(jie[i] == 2 && jie[i+1] == 3) {
				change[n++] = 's';
				change[n++] = 'd';
				change[n++] = 's';
			}
			else if(jie[i] == 3 && jie[i+1] == 1) {
				change[n++] = 's';
				change[n++] = 'd';
				change[n++] = 's';
			}
			else if(jie[i] == 3 && jie[i+1] == 2) {
				change[n++] = 's';
				change[n++] = 'a';
				change[n++] = 's';
			}
		num++;
		}
		
		else if(num%2 == 1) {
			if(jie[i] == 1 && jie[i+1] == 2) {
				change[n++] = 'd';
			}
			else if(jie[i] == 1 && jie[i+1] == 3) {
				change[n++] = 'a';
			}
			else if(jie[i] == 2 && jie[i+1] == 1) {
				change[n++] = 'a';
			}
			else if(jie[i] == 2 && jie[i+1] == 3) {
				change[n++] = 'd';
			}
			else if(jie[i] == 3 && jie[i+1] == 1) {
				change[n++] = 'd';
			}
			else if(jie[i] == 3 && jie[i+1] == 2) {
				change[n++] = 'a';
			}
		num++;
		}
	}
	for(i=0; change[i] != '\0'; i++)
		printf("%c\n",change[i]);
	return 0;
}