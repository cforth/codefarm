#include <stdio.h>


void filecopy(FILE *ifp, FILE *ofp)
{
	int c;
	while((c = getc(ifp)) != EOF) 
		putc(c, ofp);
}


int main(int argc, char *argv[])
{
	FILE *fp;
	FILE *fp_new;
	FILE *fp_head;
	FILE *fp_tail;
	
	if (argc <= 2)
		printf("my_cp: Missing file name!\n");
	else if (argc > 3)
		printf("my_cp: Too many parameter!\n");
	else {
		if((fp = fopen(*++argv, "r")) == NULL) {
			printf("my_cp: can't open %s\n", *argv);
			return 1;
		}
		else {
			if ((fp_new = fopen(*++argv, "w")) == NULL
				||	(fp_head = fopen("head.txt", "r")) == NULL
				||	(fp_tail = fopen("tail.txt", "r")) == NULL) {
				printf("error!\n");
				return 1;
			}
			else {
				filecopy(fp_head, fp_new);
				filecopy(fp, fp_new);
				filecopy(fp_tail, fp_new);
				fclose(fp_head);
				fclose(fp);
				fclose(fp_tail);
				fclose(fp_new);
			}
		}
	}
	return 0;
}
