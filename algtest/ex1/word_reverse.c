#include <stdio.h>

void ReverseString(char* s,int from,int to)
{
    while (from < to)
    {
        char t = s[from];
        s[from++] = s[to];
        s[to--] = t;
    }
}

void word_reverse(char* s, int length)
{
    int i, j;
    for(i=0,j=0; j<length+1; j++) {
        if(s[j] == ' ' || s[j] == '\0') {
            ReverseString(s, i, j-1);     //以空格为界限，对局部单词进行反转
            i = j + 1;
        }
    }
}

int main()
{
    char str[] = "I am a student.";
    int length = 15;
    word_reverse(str, length);          //对字符串中的单个单词做反转
    printf("%s\n", str);
    ReverseString(str, 0, length-1);     //对整个字符串进行反转
    printf("%s\n", str);
    return 0;
}
