#include <stdio.h>
#include <time.h>

int main()
{
	char *wday[]={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"}; 
	time_t timep; 
	struct tm *p; 
	time(&timep); 
	p=localtime(&timep); /*取得当地时间*/ 
	printf("公元时间：");
	printf ("%d/%d/%d ", (1900 + p->tm_year), ( 1 + p->tm_mon), p->tm_mday); 
	printf("%s %d:%d:%d\n", wday[p->tm_wday], p->tm_hour, p->tm_min, p->tm_sec);


	/*自己的时间系统，以90分钟为一小时*/
	int tmp;
	tmp = (p->tm_hour * 60) + p->tm_min + 30;
	printf("XX纪元时间: ");
	printf ("%d/%d/%d ", (p->tm_year - 87), ( 1 + p->tm_mon), p->tm_mday); 
	printf("%s %d:%d:%d\n", wday[p->tm_wday], (tmp / 90), (tmp % 90), p->tm_sec);
	

	return 0;
}
