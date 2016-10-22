#include <iostream>
#include <string>
using std::cout;
using std::endl;

class HasPtr {
	friend void swap(HasPtr&, HasPtr&);
public:
	//默认构造函数 
	HasPtr(const std::string &s = std::string()) :
		ps(new std::string(s)), i(0) { }
	
	//拷贝构造函数	
	HasPtr(const HasPtr &orig) : 
		ps(new std::string(*orig.ps)),
		i(orig.i) {
		cout << "copy: ";
		print(cout) << endl;	
	}
	
	//赋值运算符
	HasPtr& operator=(HasPtr rhs) {
		swap(*this, rhs);
		return *this;
	} 
	

	
	//析构函数
	~HasPtr() {
		cout << "delete: ";
		print(cout) << endl;
		delete ps;
	}
	
	//print obj status
	std::ostream& print(std::ostream &out) {
		out << "ps: " << *ps 
			 << " i: " << i;
		return out;
	} 
	
private:
	std::string *ps;
	int i;
};

//swap函数
inline
void swap(HasPtr &lhs, HasPtr &rhs) {
	using std::swap;
	cout << "swap!!!" << endl;
	swap(lhs.ps, rhs.ps);
	swap(lhs.i, rhs.i);
} 

int main() {
	HasPtr p1("111");
	HasPtr p2("222");
	cout << "===========" <<endl;
	HasPtr p3 = p2;
	cout << "===========" <<endl;
	p2 = p1;
	p3 = p1;
	cout << "===========" <<endl;
	p1.print(cout) << endl;
	p2.print(cout) << endl;
	p3.print(cout) << endl;

	return 0;
}