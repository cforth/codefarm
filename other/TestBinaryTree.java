/**
 * 二叉树实现
 * 节点为所有实现了Comparable接口的对象
 */
class BinaryTree {
	private class Node{
		private Comparable data; //排序的依据就是Comparable
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

class Book implements Comparable<Book>{ //实现比较
	private String title;
	private double price;
	public Book(String title, double price) {
		this.title = title;
		this.price = price;
	}
	@Override
	public String toString() {
		return "Book [title=" + title + ", price=" + price + "]\n";
	}
	@Override
	public int compareTo(Book o) {
		if(this.price > o.price) {
			return 1;
		}else if (this.price < o.price) {
			return -1;
		}else {
			return 0;
		}
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
		treeB.add(new Book("Java开发", 79.8));
		treeB.add(new Book("Oracle开发", 239.8));
		treeB.add(new Book("Android开发", 49.8));
		treeB.add(new Book("Jsp开发", 34.8));
		System.out.println(treeB.contains(new Book("android开发", 49.8)));
		Object[] obj = treeB.toArray();
		System.out.println(Arrays.toString(obj));
	}

}
