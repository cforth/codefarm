#include <iostream>
#include <deque>
using std::cout;
using std::endl;
using std::max;
using std::deque;
#define MAX_LENGTH 10

//带状态的备忘表元素 
struct StNum {
	int num; 
	bool state; //如果src[i]等于dest[j]，标记为true 
};

//最长公共子序列（动态规划-回溯分析）
int LCS(char *src, char *dest, int i, int j) {
	//初始化一个二维数组作为备忘表
	StNum table[MAX_LENGTH+1][MAX_LENGTH+1];
	for(int x = 0; x <= i; ++x) {
		table[x][0].num = 0;
		table[x][0].state = false;
	}
	for(int y = 0; y <= j; ++y) {
		table[0][y].num = 0;
		table[0][y].state = false;
	}

	//通过递归公式，从底向上在二维数组中填充,最后table[i][j].num就是最长子序列的长度
	for(int x = 1; x <= i; ++x)
		for(int y = 1; y <= j; ++y) {
			if(src[x-1] == dest[y-1]) {
				table[x][y].num = table[x-1][y-1].num + 1;
				table[x][y].state = true;
			}
			else {
				table[x][y].num = max(table[x][y-1].num, table[x-1][y].num);
				table[x][y].state = false;
			}
		}
	
	//根据 table[i][j].state的状态在二维数组中向斜上方回溯
	deque<char> res;
	for(int x = i, y = j; x > 0 && y > 0;) {
		if(table[x][y].state) {
			res.push_front(src[x-1]);
			x--;
			y--;
		}
		else {
			y--;
		}
	}
	
	//打印出最长子序列
	for(auto c : res)
		cout << c << " ";
	cout << endl; 
	
	return table[i][j].num;
}

int main() {
	int len_x = 7;
	int len_y = 6;
	char x[] = {'A','B','C','B','D','A','B'};
	char y[] = {'B','D','C','A','B','A'};

	cout << LCS(x,y,len_x,len_y) << endl;
}
