#include <iostream>
using namespace std;

class HasPtr {
public:
	HasPtr(const string &s = string()) :
		ps(new string(s)), i(0) { }
	
	//拷贝构造函数	
	HasPtr(const HasPtr &orig) : 
		ps(new string(*orig.ps)),
		i(orig.i) {
		cout << "test copy" << endl;	
	}

	//析构函数
	~HasPtr() { delete ps;}
 
	string *ps;
	int i;
};

int main() {
	HasPtr p;
	string s = "xxx";
	string s2 = "yyy";
	string *ss = &s;
	p.ps = ss;
	
	HasPtr p2(p);
	p.ps = &s2;
	
	cout << *(p2.ps) << endl;
	cout << *(p.ps) << endl; 
	
}
