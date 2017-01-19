#ifndef BINARY_SEARCH_TREE_H
#define BINARY_SEARCH_TREE_H
#include <functional>

//树节点模板结构体,T为节点保存的数据类型
template <typename T>
struct TreeNode {
	T key;
	TreeNode *left;
	TreeNode *right;
	TreeNode *parent;
};

//二叉搜索树模板类，T为树保存的数据类型
template <typename T>
class BinaryTree {
public:
	BinaryTree<T>() : root(NULL) {}
	TreeNode<T> *search(T key); //搜索 
	void insert(T key); //向二叉搜索树中插入一个T类型值,T类型必须实现了大于号和小于号操作符
	void remove(T key); //删除节点 
	void inorderWalk(std::function<void(T)> f); //传入一个函数对象，中序遍历对节点的值使用函数处理
	~BinaryTree<T>(); //需要销毁每一个节点
private:
	TreeNode<T> *root;
	TreeNode<T> *minHelper(TreeNode<T> *node); //node节点下最小key值的节点
	TreeNode<T> *maxHelper(TreeNode<T> *node); //node节点下最最大key值的节点 
	void inorderWalkHelper(TreeNode<T> *node, std::function<void(T)> f);
	void transplant(TreeNode<T> *u, TreeNode<T> *v);
	void freeTree(TreeNode<T> *p);
};

template <typename T>
TreeNode<T> *BinaryTree<T>::search(T key) {
	TreeNode<T> *x = root;
	while(x != NULL && key != x->key) {
		if(key < x->key)
			x = x->left;
		else
			x = x->right;
	}
	return x;
}

template <typename T>
TreeNode<T> *BinaryTree<T>::minHelper(TreeNode<T> *node) {
	while(node->left != NULL) {
		node = node->left;
	}
	return node;
} 

template <typename T>
TreeNode<T> *BinaryTree<T>::maxHelper(TreeNode<T> *node) {
	while(node->right != NULL) {
		node = node->right;
	}
	return node;
} 

template <typename T>
void BinaryTree<T>::insert(T key) {
	TreeNode<T> *y = NULL;
	TreeNode<T> *x = root;
	TreeNode<T> *z = new TreeNode<T>{key,NULL,NULL,NULL};
	while(x != NULL) {
		y = x;
		if(z->key < x->key)
			x = x->left;
		else
			x = x->right;
	}
	z->parent = y;
	if(y == NULL)
		root = z;
	else if(z->key < y->key)
		y->left = z;
	else
		y->right = z;
}

template <typename T>
void BinaryTree<T>::remove(T key) {
	TreeNode<T> *z = search(key);
	if(z == NULL) return;
	if(z->left == NULL)
		transplant(z,z->right);
	else if(z->right == NULL)
		transplant(z,z->left);
	else {
		TreeNode<T> *y = minHelper(z->right);
		if(y->parent != z) {
			transplant(y,y->right);
			y->right = z->right;
			y->right->parent = y;
		}
		transplant(z,y);
		y->left = z->left;
		y->left->parent = y;
	}
	delete(z);
}

template <typename T>
void BinaryTree<T>::inorderWalkHelper(TreeNode<T> *node, std::function<void(T)> f) {
	if(node) {
		inorderWalkHelper(node->left, f);
		f(node->key);
		inorderWalkHelper(node->right, f);
	}
}

template <typename T>
void BinaryTree<T>::inorderWalk(std::function<void(T)> f) {
	inorderWalkHelper(root, f);
}

template <typename T>
void BinaryTree<T>::transplant(TreeNode<T> *u, TreeNode<T> *v) {
	if(u->parent == NULL)
		root = v;
	else if(u == u->parent->left)
		u->parent->left = v;
	else
		u->parent->right = v;
	if(v != NULL)
		v->parent = u->parent;
}

template <typename T>
void BinaryTree<T>::freeTree(TreeNode<T> *p){
	if(p->left)
		freeTree(p->left);
	if(p->right)
		freeTree(p->right);
	delete(p);
}

template <typename T>
BinaryTree<T>::~BinaryTree<T>() {
	if(root)
		freeTree(root);
}
#endif