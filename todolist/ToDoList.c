#include <stdio.h>
#include <time.h>

void filecopy(FILE *, FILE*);
void get_date( void );

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
	int c;

	while((c = getc(ifp)) != EOF) {
		switch(c){
		case '&':
			get_date();
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
	strftime(now, 79, "%Y-%m-%d\n%H:%M:%S",at);
	puts(now);
}
