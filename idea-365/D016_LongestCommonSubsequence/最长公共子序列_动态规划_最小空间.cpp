#include <iostream>
using std::cout;
using std::endl;
using std::max;
#define MAX_LENGTH 10

//最长公共子序列（动态规划-最小空间复杂度O(min(m,n)*2)，无法回溯）
int LCS(char *src, char *dest, int i, int j) {
	//因为只需要利用前一行的数据推算，可以用行数为2的二维数组最为备忘表。
	int table[2][j+1]; //gcc支持变长数组
	for(int x = 0; x < 2; ++x)
		table[x][0] = 0;
	for(int y = 0; y <= j; ++y)
		table[0][y] = 0;
	//通过递归公式，向二维数组内填充，反复利用两行。
	for(int x = 1; x <= i; ++x)
		for(int y = 1; y <= j; ++y) {
			if(src[x-1] == dest[y-1])
				table[x%2][y] = table[(x-1)%2][y-1] + 1;
			else
				table[x%2][y] = max(table[x%2][y-1], table[(x-1)%2][y]);
		}
	return table[i%2][j];
}

int main() {
	int len_x = 7;
	int len_y = 8;
	char x[] = {'A','B','C','B','D','A','B'};
	char y[] = {'B','D','C','A','B','A','B','C'};
	int res;
	//确保利用最小空间保存备忘表table
	if(len_x > len_y)
		res = LCS(x,y,len_x,len_y);
	else
		res = LCS(y,x,len_y,len_x);
		
	cout << res << endl;
}
