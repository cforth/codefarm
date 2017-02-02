#include "RBTree.h"
#include <iostream>
using std::cout;
using std::cin;
using std::endl;

int main() {
	Node *nil = new Node{BLACK,INT_MIN,NULL,NULL,NULL};
	Node *root = nil;
	RBTree rbtree = {root, nil};
	RBTree *rbt = &rbtree;
	
	int num[9] = {9,7,8,5,4,3,6,2,1};
	for(int x = 0; x < 9; ++x) {
		Node *z = new Node{RED,num[x],rbt->nil,rbt->nil,rbt->nil};
		rb_insert(rbt, z);
	}
	cout << "root->key: " << rbt->root->key << endl;
	inorder_traverse(rbt, rbt->root);
	
	cout << "delete test:" << endl;
	for(int x = 1; x <= 9; ++x) {
		cout << "delete: " << x << endl;
		Node *n = rb_search(rbt, x);
		if(n != rbt->nil) {
			rb_delete(rbt, n);
			cout << "root->key: " << rbt->root->key << endl;
			inorder_traverse(rbt, rbt->root);
		}
		cout << endl;
	}

	return 0;
}