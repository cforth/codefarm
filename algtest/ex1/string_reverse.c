#include <stdio.h>

void ReverseString(char *s,int from,int to)
{
    while (from < to)
    {
        char t = s[from];
        s[from++] = s[to];
        s[to--] = t;
    }
}

void LeftRotateString(char *s,int n,int m)
{
    m %= n;               //若要左移动大于n位，那么和%n 是等价的
    ReverseString(s, 0, m - 1); //反转[0..m - 1]，套用到上面举的例子中，就是X->X^T，即 abc->cba
    ReverseString(s, m, n - 1); //反转[m..n - 1]，例如Y->Y^T，即 def->fed
    ReverseString(s, 0, n - 1); //反转[0..n - 1]，即如整个反转，(X^TY^T)^T=YX，即 cbafed->defabc。
}

void RightRotateString(char *s,int n,int m)
{
    LeftRotateString(s, n, n-m);
}

int main()
{
    char str[] = "Ilovebaofeng";  //注意char *str = "Ilovebaofeng" 是不对的，这样无法修改字符串。
    RightRotateString(str, 12, 7);
    printf("%s\n", str);
    return 0;
}
