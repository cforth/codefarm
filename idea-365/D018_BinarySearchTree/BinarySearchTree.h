#ifndef BINARY_SEARCH_TREE_H
#define BINARY_SEARCH_TREE_H
#include <functional>

//树节点模板结构体,T为节点保存的数据类型
template <typename T>
struct TreeNode {
	T val;
	TreeNode *left;
	TreeNode *right;
};

//二叉搜索树模板类，T为树保存的数据类型
template <typename T>
class BinaryTree {
public:
	BinaryTree<T>() : root(NULL) {}
	TreeNode<T>* insert(T val); //向二叉搜索树中插入一个T类型值,T类型必须实现了大于号和小于号操作符
	void inorderTraverse(std::function<void(T)> f); //传入一个函数对象，中序遍历对节点的值使用函数处理
	~BinaryTree<T>(); //需要销毁每一个节点
private:
	TreeNode<T> *root;
	TreeNode<T>* insertHelper(T val, TreeNode<T> *node);
	void inorderTraverseHelper(TreeNode<T> *node, std::function<void(T)> f);
	void freeTree(TreeNode<T> *p);
};

template <typename T>
TreeNode<T>* BinaryTree<T>::insert(T val) {
	if(!root) {
		root = new TreeNode<T>{val,NULL,NULL};
		return root;
	}
	return insertHelper(val, root);
}

template <typename T>
TreeNode<T>* BinaryTree<T>::insertHelper(T val, TreeNode<T> *node) {
	if(!node) {
		return new TreeNode<T>{val,NULL,NULL};
	}
	if(val < node->val) {
		node->left = insertHelper(val, node->left);
	}
	else if(val > node->val) {
		node->right = insertHelper(val, node->right);
	}
	else {
		node->val = val;
	}
	return node;
}

template <typename T>
void BinaryTree<T>::inorderTraverseHelper(TreeNode<T> *node, std::function<void(T)> f) {
	if(node) {
		inorderTraverseHelper(node->left, f);
		f(node->val);
		inorderTraverseHelper(node->right, f);
	}
}

template <typename T>
void BinaryTree<T>::inorderTraverse(std::function<void(T)> f) {
	inorderTraverseHelper(root, f);
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