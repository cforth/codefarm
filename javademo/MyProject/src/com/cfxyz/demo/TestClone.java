package com.cfxyz.demo;

class Booka implements Cloneable {
	private String title;
	private double price;
	public Booka(String title, double price) {
		this.title = title;
		this.price = price;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "Booka [title=" + title + ", price=" + price + "]";
	}
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}

public class TestClone {

	public static void main(String[] args) throws Exception{
		Booka BookaA = new Booka("JAVA开发", 99.8);
		Booka BookaB = (Booka) BookaA.clone();
		System.out.println(BookaA);
		System.out.println(BookaB);
		BookaA.setTitle("Android开发");
		System.out.println(BookaA);
		System.out.println(BookaB);
	}

}
