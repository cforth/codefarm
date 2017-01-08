#include <cstdio>
#include <cstring>

int max(int a, int b) {
	return a > b ? a : b;
}

//最长公共子序列（朴素算法）,速度非常慢
int LCS(char *src, char *dest, int i, int j) {
	if(i < 0 || j < 0)
		return 0;
	if(src[i] == dest[j])
		return LCS(src, dest, i-1, j-1) + 1;
	else
		return max(LCS(src, dest, i-1, j), LCS(src, dest, i, j-1));
}

int main() {
	int len_x = 7;
	int len_y = 6;
	char x[] = {'A','B','C','B','D','A','B'};
	char y[] = {'B','D','C','A','B','A'};

	printf("%d\n", LCS(x,y,len_x-1,len_y-1));
	
	char *s1 = "helloworld";
	char *s2 = "howareyou";
	printf("%d\n", LCS(s1,s2,strlen(s1)-1,strlen(s2)-1));
}
