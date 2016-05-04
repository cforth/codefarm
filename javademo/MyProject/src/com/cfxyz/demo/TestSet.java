package com.cfxyz.demo;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;
import java.util.TreeSet;
import java.util.Vector;

class BookH implements Comparable<BookH> {
	private String title;
	private double price;
	public BookH(String title, double price) {
		this.title = title;
		this.price = price;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		long temp;
		temp = Double.doubleToLongBits(price);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookH other = (BookH) obj;
		if (Double.doubleToLongBits(price) != Double.doubleToLongBits(other.price))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BookH [title=" + title + ", price=" + price + "]\n";
	}

	@Override
	public int compareTo(BookH o) {
		if(this.price > o.price) {
			return 1;
		} else if (this.price < o.price) {
			return  -1;
		} else {
			return this.title.compareTo(o.title);
		}
	}
	
}


public class TestSet {

	public static void main(String[] args) {
		
		//HashSet
		Set<String> set = new HashSet<String>();
		set.add("B");
		set.add("X");
		set.add("A");
		set.add("C");
		System.out.println(set);
		
		//TreeSet
		Set<String> tree = new TreeSet<String>();
		tree.add("X");
		tree.add("A");
		tree.add("C");
		tree.add("B");
		System.out.println(tree);
		
		//��һ�ֵ��������iterator���Ƽ���
		Set<BookH> all = new HashSet<BookH>();
		all.add(new BookH("Java����", 79.8));
		all.add(new BookH("Java����", 79.8));
		all.add(new BookH("Java����", 59.8));
		all.add(new BookH("Jsp����", 39.8));
		System.out.println(all);

		Iterator<BookH> iter = all.iterator();
		while(iter.hasNext()) {
			System.out.println(iter.next());
		}
		
		//�ڶ��ֵ��������listIterator
		List<String> list = new ArrayList<String>();
		list.add("A");
		list.add("B");
		list.add("C");
		ListIterator<String> listiter = list.listIterator();
		//���Ҫʵ���Һ���ǰ�����һ��Ҫ���ȷ�����ǰ������
		System.out.println("��ǰ��������");
		while(listiter.hasNext()) {
			System.out.println(listiter.next());
		}
		System.out.println("�ɺ���ǰ�����");
		while(listiter.hasPrevious()) {
			System.out.println(listiter.previous());
		}
		
		//�����ֵ��������foreach
		for(String str: list) {
			System.out.println(str);
		}
		
		//�����ֵ��������Enumeration
		Vector<String> vec = new Vector<String>();
		vec.add("A");
		vec.add("B");
		vec.add("C");
		Enumeration<String> enu = vec.elements();
		while(enu.hasMoreElements()) {
			System.out.println(enu.nextElement());
		}
	}

}
