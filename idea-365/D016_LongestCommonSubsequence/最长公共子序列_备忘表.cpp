#include <iostream>
using std::cout;
using std::endl;
using std::max;

//最长公共子序列（备忘表）
//使用一个二维数组C[m][n]来记录计算结果，对于已经计算过的C[i,j]直接查表得出。
int LCS(char *src, char *dest, int i, int j, int **table) {
	if(i < 0 || j < 0)
		return 0;

 	if(table[i][j] == 0) {
		if(src[i] == dest[j])
			table[i][j] = LCS(src, dest, i-1, j-1, table) + 1;
		else
			table[i][j] = max(LCS(src, dest, i-1, j, table), LCS(src, dest, i, j-1, table));
	}
	return table[i][j];
}

int main() {
	int len_x = 7;
	int len_y = 6;
	char x[] = {'A','B','C','B','D','A','B'};
	char y[] = {'B','D','C','A','B','A'};
	
	//初始化一个二维数组作为备忘表，用0填充，代表没有记录的标志
	int max_len = 10;
	int **table = new int*[max_len];
	for(int x = 0; x < max_len; ++x) {
			table[x] = new int[max_len];
	}
	for(int x = 0; x < max_len; ++x) {
		for(int y = 0; y < max_len; ++y)
			table[x][y] = 0;
	}

	cout << LCS(x,y,len_x-1,len_y-1, table) << endl;
	
	//打印出二维数组
	for(int x = 0; x < max_len; ++x) {
		for(int y = 0; y < max_len; ++y)
			cout << table[x][y] << " ";
		cout << endl;
	}
}
