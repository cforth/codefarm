#include <iostream>
#include <cstring>
using std::cout;
using std::cin;
using std::endl;
using std::min;

#define MAX_STRING_LEN 5

int EditDistance(char *src, char *dest)
{
    int i,j;
    int d[MAX_STRING_LEN][MAX_STRING_LEN] = { 0xFFFF };

    for(i = 0; i <= strlen(src); i++)
        d[i][0] = i;
    for(j = 0; j <= strlen(dest); j++)
        d[0][j] = j;

    for(i = 1; i <= strlen(src); i++)
    {
        for(j = 1; j <= strlen(dest); j++)
        {
            if((src[i - 1] == dest[j - 1]))
            {
                d[i][j] = d[i - 1][j - 1]; //不需要编辑操作
            }
            else
            {
                int edIns = d[i][j - 1] + 1; //source 插入字符
                int edDel = d[i - 1][j] + 1; //source 删除字符
                int edRep = d[i - 1][j - 1] + 1; //source 替换字符

                d[i][j] = min(min(edIns, edDel), edRep);
            }
        }
    }

    return d[strlen(src)][strlen(dest)];
}

int main() {
	char s[] = "SNOWY";
	char d[] = "SUNNY";
	
	cout << EditDistance(s,d) << endl;
}
