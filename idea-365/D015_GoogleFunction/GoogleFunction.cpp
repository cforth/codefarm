#include <cstdio>

//有一个由字符组成的等式：WWWDOT - GOOGLE = DOTCOM，
//每个字符代表一个0～9之间的数字，WWWDOT、GOOGLE和DOTCOM都是合法的数字，不能以0开头。
//请找出一组字符和数字的对应关系，使它们互相替换，并且替换后的数字能够满足等式。 

//保存字符与数字的匹配结果 
typedef struct tagCharItem
{
    char c;
    int value;
    bool leading; //标志位，首字符不能为零 
}CHAR_ITEM;

//保存数字的使用标志 
typedef struct tagCharValue
{
    bool used;
    int value;
}CHAR_VALUE;

typedef void (*CharListReadyFuncPtr)(CHAR_ITEM[]);
int MakeIntegerValue(CHAR_ITEM ci[], char* str);
bool IsValueValid(CHAR_ITEM ci, CHAR_VALUE cv);
void OnCharListReady(CHAR_ITEM ci[]);
void SearchingResult(CHAR_ITEM ci[], CHAR_VALUE cv[],
    int index, CharListReadyFuncPtr callback);


//通过暴力穷举法对每个字符进行匹配后验证 
void SearchingResult(CHAR_ITEM ci[], CHAR_VALUE cv[],
    int index, CharListReadyFuncPtr callback)
{
	int max_char_count = 9; //ci[]的长度 
	int max_number_count = 10; //0-9
	
    if(index == max_char_count) //如果所有字符都已经匹配上数字，进行验证 
    {
        callback(ci); //验证函数 
        return;
    }

    for(int i = 0; i < max_number_count; ++i)
    {
        if(IsValueValid(ci[index], cv[i])) //去掉不需要匹配的情况 
        {
            cv[i].used = true;/*set used sign*/
            ci[index].value = cv[i].value;
            SearchingResult(ci, cv, index + 1, callback);
            cv[i].used = false;/*clear used sign*/
        }
    }
}
 
//验证函数，验证等式是否成立 
void OnCharListReady(CHAR_ITEM ci[])
{
    char *minuend    = "WWWDOT";
    char *subtrahend = "GOOGLE";
    char *diff       = "DOTCOM";

    int m = MakeIntegerValue(ci, minuend);
    int s = MakeIntegerValue(ci, subtrahend);
    int d = MakeIntegerValue(ci, diff);
    if((m - s) == d)
    {
    	printf("%d - %d = %d\n",m,s,d);
    }
}

//评估函数，通过剪枝操作去除掉无需匹配的情况 
bool IsValueValid(CHAR_ITEM ci, CHAR_VALUE cv)
{
	if(cv.used) return false;
	if(ci.leading && cv.value == 0) {
		return false;
	}
	return true;
}

//将等式中的字符串转为整数 
int MakeIntegerValue(CHAR_ITEM ci[], char* str) {
	int sum = 0;
	for(char *c = str; *c != '\0'; ++c) {
		for(int x = 0; x < 9; ++x) {
			if(ci[x].c == *c) {
				sum = sum*10 + ci[x].value;
				break;
			}
		}
	}
	return sum;
}

int main() {
	CHAR_ITEM charItem[] = { { 'W', -1, true  }, { 'D', -1, true  }, { 'O', -1, false },
                         { 'T', -1, false }, { 'G', -1, true  }, { 'L', -1, false },
                         { 'E', -1, false }, { 'C', -1, false }, { 'M', -1, false } };
    CHAR_VALUE charValue[] = { {false, 0}, {false, 1}, {false, 2}, 
							{false, 3}, {false, 4}, {false, 5}, 
							{false, 6}, {false, 7}, {false, 8}, {false, 9} };
	SearchingResult(charItem, charValue, 0, OnCharListReady);
}
