#ifndef RED_BLACK_TREE_H
#define RED_BLACK_TREE_H
#include <iostream>
using std::cout;
using std::cin;
using std::endl;

#define RED false
#define BLACK true

struct Node {
	bool color;
	int key;
	Node *left;
	Node *right;
	Node *p;
};

struct RBTree {
	Node *root; //根节点
	Node *nil; //哨兵叶节点
};

void left_rotate(RBTree *t, Node *x) {
	Node *y = x->right;
	x->right = y->left;
	if(y->left != t->nil) {
		y->left->p = x;
	}
	y->p = x->p;
	if(x->p == t->nil) {
		t->root = y;
	}
	else if(x == x->p->left) {
		x->p->left = y;
	}
	else {
		x->p->right = y;
	}
	y->left = x;
	x->p = y;
}

void right_rotate(RBTree *t, Node *y) {
	Node *x = y->left;
	y->left = x->right;
	if(x->right != t->nil) {
		x->right->p = y;
	}
	x->p = y->p;
	if(y->p == t->nil) {
		t->root = x;
	}
	else if(y == y->p->left) {
		y->p->left = x;
	}
	else {
		y->p->right = x;
	}
	x->right = y;
	y->p = x;
}

void rb_insert_fixup(RBTree *t, Node *z) {
	while(z->p->color == RED) {
		if(z->p == z->p->p->left) {
			Node *y = z->p->p->right;
			if(y->color == RED) {
				z->p->color = BLACK;
				y->color = BLACK;
				z->p->p->color = RED;
				z = z->p->p;
			}
			else if(z == z->p->right) {
				z = z->p;
				left_rotate(t, z);
			}
			else {
				z->p->color = BLACK;
				z->p->p->color = RED;
				right_rotate(t, z->p->p);
			}
		}
		else {
			Node *y = z->p->p->left;
			if(y->color == RED) {
				z->p->color = BLACK;
				y->color = BLACK;
				z->p->p->color = RED;
				z = z->p->p;
			}
			else if(z == z->p->left) {
				z = z->p;
				right_rotate(t, z);
			}
			else {
				z->p->color = BLACK;
				z->p->p->color = RED;
				left_rotate(t, z->p->p);
			}
		}
	}
	t->root->color = BLACK;
}

void rb_insert(RBTree *t, Node *z) {
	Node *y = t->nil;
	Node *x = t->root;
	while(x != t->nil) {
		y = x;
		if(z->key < x->key) {
			x = x->left;
		}
		else {
			x = x->right;
		}
	}
	z->p = y;
	if(y == t->nil) {
		t->root = z;
	}
	else if(z->key < y->key) {
		y->left = z;
	}
	else {
		y->right = z;
	}
	z->left = t->nil;
	z->right = t->nil;
	z->color = RED;
	rb_insert_fixup(t, z);
}

void rb_transplant(RBTree *t, Node *u, Node *v) {
	if(u->p == t->nil) {
		t->root = v;
	}
	else if(u == u->p->left) {
		u->p->left = v;
	}
	else {
		u->p->right = v;
	}
	v->p = u->p;
}

Node* tree_minimum(RBTree *t, Node *x) {
	while(x->left != t->nil) {
		x = x->left;
	}
	return x;
}

void rb_delete_fixup(RBTree *t, Node *x) {
	while(x != t->root && x->color == BLACK) {
		Node *w;
		if(x == x->p->left) {
			w = x->p->right;
			if(w->color == RED) {
				w->color = BLACK;
				x->p->color = RED;
				left_rotate(t, x->p);
				w = x->p->right;
			}
			if(w->left->color == BLACK && w->right->color == BLACK) {
				w->color = RED;
				x = x->p;
			}
			else if(w->right->color == BLACK) {
				w->left->color = BLACK;
				w->color = RED;
				right_rotate(t, w);
				w = x->p->right;
			}
			else {
				w->color = x->p->color;
				x->p->color = BLACK;
				w->right->color = BLACK;
				left_rotate(t, x->p);
				x = t->root;
			}
		}
		else {
			w = x->p->left;
			if(w->color == RED) {
				w->color = BLACK;
				x->p->color = RED;
				right_rotate(t, x->p);
				w = x->p->left;
			}
			if(w->right->color == BLACK && w->left->color == BLACK) {
				w->color = RED;
				x = x->p;
			}
			else if(w->left->color == BLACK) {
				w->right->color = BLACK;
				w->color = RED;
				left_rotate(t, w);
				w = x->p->left;
			}
			else {
				w->color = x->p->color;
				x->p->color = BLACK;
				w->left->color = BLACK;
				right_rotate(t, x->p);
				x = t->root;
			}
		}
	}
	x->color = BLACK;
}

void rb_delete(RBTree *t, Node *z) {
	Node *y = z;
	Node *x;
	bool y_original_color = y->color;
	if(z->left == t->nil) {
		x = z->right;
		rb_transplant(t, z, z->right);
	}
	else if(z->right == t->nil) {
		x = z->left;
		rb_transplant(t, z, z->left);
	}
	else {
		y = tree_minimum(t, z->right);
		y_original_color = y->color;
		x = y->right;
		if(y->p == z) {
			x->p = y;
		}
		else {
			rb_transplant(t, y, y->right);
			y->right = z->right;
			y->right->p = y;
		}
		rb_transplant(t, z, y);
		y->left = z->left;
		y->left->p = y;
		y->color = z->color;
	}
	if(y_original_color == BLACK) {
		rb_delete_fixup(t, x);
	}
	delete(z);
}

void inorder_traverse(RBTree *t, Node *x) {
	if(x != t->nil) {
		inorder_traverse(t, x->left);
		cout << "node->key: " << x->key
			<< " node->color: " << (x->color == RED ? "RED" : "BLACK");
		if(x->left != t->nil)
			cout << " node->left: " << x->left->key;
		else
			cout << " node->left: NIL";
		if(x->right != t->nil)
			cout << " node->right: " << x->right->key;
		else
			cout << " node->right: NIL";
		cout << endl;
		inorder_traverse(t, x->right);
	}
}

Node* rb_search(RBTree *t, int key) {
	Node *x = t->root;
	while(x->key != key && x != t->nil) {
		if(key < x->key) {
			x = x->left;
		}
		else {
			x = x->right;
		}
	}
	return x;
}

#endif