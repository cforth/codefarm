#include "test_13_39.h"
#include <iostream>
#include <string>
#include <memory>
using std::string;
using std::allocator;
using std::cout;
using std::endl;

allocator<string> StrVec::alloc;

int main() {
	StrVec sv;
	sv.push_back("1235");
	sv.push_back("sdfasdf0");
	for(auto p = sv.begin(); p != sv.end(); ++p) {
		cout << *p << endl;
	}
	
	StrVec sv2(sv);
	for(auto p = sv2.begin(); p != sv2.end(); ++p) {
		cout << *p << endl;
	}
	
	return 0;
}

