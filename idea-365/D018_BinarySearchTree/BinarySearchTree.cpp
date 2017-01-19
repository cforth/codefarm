#include "BinarySearchTree.h"
#include <iostream>
#include <string>
using std::cout;
using std::cin;
using std::endl;
using std::string;

int main() {
	BinaryTree<int> int_tree;
	int num[7] = {3,1,8,2,6,7,5};
	for(int x = 0; x < 7; ++x) {
		int_tree.insert(num[x]);
	}
	int_tree.inorderWalk([](int x){cout << x << " ";});
	cout << endl;
	int_tree.remove(6);
	int_tree.remove(3);
	int_tree.inorderWalk([](int x){cout << x << " ";});
	cout << endl;
	
	BinaryTree<float> float_tree;
	float num2[7] = {3.1,1.2,8.3,2.4,6.5,7.6,5.7};
	for(int x = 0; x < 7; ++x) {
		float_tree.insert(num2[x]);
	}
	float_tree.inorderWalk([](double x){cout << x << " | ";});
	cout << endl;
	
	BinaryTree<string> str_tree;
	string num3[5] = {"abc","cba","bca","bac","cab"};
	for(int x = 0; x < 5; ++x) {
		str_tree.insert(num3[x]);
	}
	str_tree.inorderWalk([](string x){cout << x << " ";});
	cout << endl;
	
	string s = "bca";
	auto res = str_tree.search(s);
	if(res)
		cout << res->key << endl;
	else
		cout << "no key!!" << endl;
}