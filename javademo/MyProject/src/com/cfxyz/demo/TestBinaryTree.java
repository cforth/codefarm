package com.cfxyz.demo;

import java.util.Arrays;

/**
 * ������ʵ��
 * �ڵ�Ϊ����ʵ����Comparable�ӿڵĶ���
 */
class BinaryTree {
	private class Node{
		private Comparable data; //��������ݾ���Comparable
		private Node left;
		private Node right;
		
		public Node(Comparable data) {
			this.data = data;
		}
		
		public void addNode(Node newNode) {
			if(this.data.compareTo(newNode.data) < 0) {
				if(this.right == null) {
					this.right = newNode;
				} else {
					this.right.addNode(newNode);
				}
			} else {
				if(this.left == null){
					this.left = newNode;
				} else {
					this.left.addNode(newNode);
				}
			}
		}
		
		public boolean containsNode(Comparable data) {
			if(this.data.compareTo(data) == 0) {
				return true;
			}else if(this.data.compareTo(data) < 0) {
				if(this.right != null) {
					return this.right.containsNode(data);
				} else {
					return false;
				}
			} else  {
				if(this.left != null) {
					return this.left.containsNode(data);
				} else {
					return false;
				}
			}
		}
		
		public void toArrayNode() {
			if (this.left != null) {
				this.left.toArrayNode();
			}
			BinaryTree.this.retData[BinaryTree.this.foot ++] = this.data;
			if (this.right != null){
				this.right.toArrayNode();
			}
		}
	}
	
	private Node root;
	private int count = 0;
	private Object[] retData;
	private int foot;
	
	public void add(Object obj) {
		if(obj == null) {
			return;
		}
		Comparable data = (Comparable)obj;
		Node newNode = new Node(data);
		if(this.root == null) {
			this.root = newNode;
		} else {
			this.root.addNode(newNode);
		}
		this.count++;
	}
	
	public boolean contains(Object obj) {
		if(this.root == null) {
			return false;
		}
		return this.root.containsNode((Comparable)obj);
	}
	
	public Object[] toArray() {
		if(this.root == null) {
			return null;
		}
		this.foot = 0;
		this.retData = new Object[this.count];
		this.root.toArrayNode();
		return this.retData;
	}
}

public class TestBinaryTree {

	public static void main(String[] args) {
		BinaryTree treeA = new BinaryTree();
		treeA.add(5);
		treeA.add(3);
		treeA.add(6);
		treeA.add(7);
		treeA.add(1);
		System.out.println(treeA.contains(2));
		System.out.println(treeA.contains(3));
		
		BinaryTree treeB = new BinaryTree();
		treeB.add(new Book("Java����", 79.8));
		treeB.add(new Book("Oracle����", 239.8));
		treeB.add(new Book("Android����", 49.8));
		treeB.add(new Book("Jsp����", 34.8));
		System.out.println(treeB.contains(new Book("android����", 49.8)));
		Object[] obj = treeB.toArray();
		System.out.println(Arrays.toString(obj));
	}

}
