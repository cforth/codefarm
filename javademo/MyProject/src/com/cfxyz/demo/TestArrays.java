package com.cfxyz.demo;

import java.util.Arrays;

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

public class TestArrays {

	public static void main(String[] args) {
//		int data[] = {1,4,5,6,7,8,9,2,3};
//		java.util.Arrays.sort(data);
//		System.out.println(Arrays.binarySearch(data, 8));
//		int dataA[] = new int [] {1,2,3};
//		int dataB[] = new int [] {2,3,1};
//		System.out.println(Arrays.equals(dataA, dataB));
//		int dataC[] = new int [10];
//		Arrays.fill(dataC, 4);
//		System.out.println(Arrays.toString(dataC));
		Book books [] = new Book [] {
				new Book("java开发", 79.8),
				new Book("ocale开发", 239.8),
				new Book("android开发", 49.8),
				new Book("jsp开发", 34.8)
		};
		Arrays.sort(books);
		System.out.println(Arrays.toString(books));
	}

}
