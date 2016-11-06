#include "test_13_43.h"
#include <iostream>
#include <string>
#include <memory>
using std::string;
using std::allocator;
using std::cout;
using std::endl;

allocator<string> StrVec::alloc;

int main() {
	StrVec sv({"sadf","sdfsadfasf","sadfsadf"});
	for(auto p = sv.begin(); p != sv.end(); ++p) {
		cout << *p << endl;
	}
	
	StrVec sv2(sv);
	for(auto p = sv2.begin(); p != sv2.end(); ++p) {
		cout << *p << endl;
	}
	
	return 0;
}

