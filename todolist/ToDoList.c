#include <stdio.h>
#include <time.h>

void filecopy(FILE *, FILE*);
void get_date( void );
void print_rim( void );

int main( int argc, char *argv[] )
{
	FILE *fp;
	
	if(argc == 1)
		filecopy(stdin, stdout);
	else
		while(--argc > 0)
			if((fp = fopen(*++argv, "r")) == NULL) {
				printf("ToDoList: can't open %s\n", *argv);
				return 1;
			}
			else {
				filecopy(fp, stdout);
				fclose(fp);
			}
	return 0;
}


void filecopy(FILE *ifp, FILE *ofp)
{
	int c, old_f;

	while((c = getc(ifp)) != EOF) {
		switch(c){
		case '$':
			old_f = c;
			c = getc(ifp);
			switch(c) {
			case '1':
				get_date();
				break;
			case '2':
				print_rim();
				break;
			default :
				putc(old_f, ofp);
				putc(c, ofp);
			}
			break;
		default :
			putc(c, ofp);
		}
	}
}


void get_date( void )
{
	time_t my_time;
	struct tm *at;
	char now[80];
	time(&my_time);
	at = localtime(&my_time);
	strftime(now, 79, "%Y-%m-%d %H:%M:%S",at);
	fputs(now,stdout);
}


void print_rim( void )
{
	printf(" 0 \n/I\\\n ^\n/ \\\n");
}
