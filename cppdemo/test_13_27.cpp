#include <iostream>
#include <string>
using namespace std;

class HasPtr {
public:
	HasPtr(const string &s = string()) :
		ps(new string(s)), i(0), use(new size_t(1)) { }
	
	//�������캯��	
	HasPtr(const HasPtr &orig) : 
		ps(orig.ps),
		i(orig.i),
		use(orig.use) {
		++*use;
		cout << "test copy: " 
			 << "ps: " << *ps 
			 << " i: " << i
			 << " use: " << *use
			 << endl;	
	}
	
	//��ֵ�����
	HasPtr& operator=(const HasPtr &rhs) {
		++*rhs.use;
		if(--*use == 0) {
			cout << "delete myself: "
			 	 << "ps: " << *ps 
			 	 << " i: " << i
			 	 << " use: " << *use
			 	 << endl;
			delete ps;
			delete use;
		}
		ps = rhs.ps;
		i = rhs.i;
		use = rhs.use;
		return *this;
	} 

	//��������
	~HasPtr() {
		if(--*use == 0) {
			cout << "delete myself: "
			 	 << "ps: " << *ps 
			 	 << " i: " << i
			 	 << " use: " << *use
			 	 << endl;
			delete ps;
			delete use;
		}
	}
	
	//print
	void print() {
		cout << *ps << " " << i << " " << *use << endl;
	} 
	
private:
	string *ps;
	int i;
	size_t *use; //����ʵ�����ü��� 
};

int main() {
	HasPtr p1("111");
	HasPtr p2("222");
	HasPtr p3 = p2;
	p2 = p1;
	p3 = p1;
	cout << "===========" <<endl;
	p1.print();
	p2.print();
	p3.print();

	return 0;
}
