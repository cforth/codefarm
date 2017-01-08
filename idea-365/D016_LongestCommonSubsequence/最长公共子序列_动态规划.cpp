#include <iostream>
using std::cout;
using std::endl;
using std::max;
#define MAX_LENGTH 10

//最长公共子序列（动态规划）
int LCS(char *src, char *dest, int i, int j) {
	//初始化一个二维数组作为备忘表
	int table[MAX_LENGTH+1][MAX_LENGTH+1];
	for(int x = 0; x <= i; ++x)
		table[x][0] = 0;
	for(int y = 0; y <= j; ++y)
		table[0][y] = 0;
	//通过递归公式，从底向上在二维数组中填充,最后table[i][j]就是最长子序列的长度
	for(int x = 1; x <= i; ++x)
		for(int y = 1; y <= j; ++y) {
			if(src[x-1] == dest[y-1])
				table[x][y] = table[x-1][y-1] + 1;
			else
				table[x][y] = max(table[x][y-1], table[x-1][y]);
		}
	return table[i][j];
}

int main() {
	int len_x = 7;
	int len_y = 6;
	char x[] = {'A','B','C','B','D','A','B'};
	char y[] = {'B','D','C','A','B','A'};

	cout << LCS(x,y,len_x,len_y) << endl;
}
