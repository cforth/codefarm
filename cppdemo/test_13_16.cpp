#include <iostream>
#include <string>
using namespace std;

class Employee {
public:
	Employee(const string &s = string()):
		name(new string(s)),
		id(++num) { }
	
	Employee(const Employee& e) :
		name(new string(*e.name)),
		id(e.id) {
		}
	
	~Employee() {
		delete name;
	}
	static int num;
	string *name;
	int id;

};

int Employee::num = 0;

int main() {
	Employee emp1, emp2;
	cout << *emp1.name << " " << emp1.id << endl;
	cout << *emp2.name << " " << emp2.id << endl;
	
	Employee emp3("cf"), emp4("hk");
	cout << *emp3.name << " " << emp3.id << endl;
	cout << *emp4.name << " " << emp4.id << endl;
	
	Employee emp5(emp3);
	cout << *emp5.name << " " << emp5.id << endl;
	*emp3.name = string("xxx");
	cout << *emp5.name << " " << emp5.id << endl;
	cout << *emp3.name << " " << emp3.id << endl;
	return 0;
}
