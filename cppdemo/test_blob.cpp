#include "Blob.h"
#include <iostream>
#include <string>
using std::cout;
using std::endl;
using std::string;

int main() {
	Blob<int> ia;
	Blob<int> ia2 = {0,1,2,3,4,5};
	for(int x = 0; x < ia2.size(); ++x)
	    cout << ia2[x] << " ";
	cout << endl;
	
	Blob<string> ia3 = {"Hello", "World", "!!"};
	for(int x = 0; x < ia3.size(); ++x)
	    cout << ia3[x] << " ";
	cout << endl;
}
