#include <iostream>
#include <fstream>
#include <string>
#include "Sales_data_class.h"
using namespace std;
int main(int argc, char* argv[]) {
	ifstream input(argv[1]);
	ofstream output(argv[2], ofstream::out | ofstream::app);
	Sales_data total;
	if(read(input, total)) {
		Sales_data trans;
		while (read(input, trans)) {
			if(total.isbn() == trans.isbn())
				total = add(total, trans);
			else {
				print(output, total) << endl;
				total = trans;
			}
		}
		Sales_data xxx = total; //测试拷贝初始化 
		print(output, xxx) << endl;
	} else {
		cerr << "No data?!" << endl;
		return -1;
	}
	return 0;
}
