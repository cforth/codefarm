package com.cfxyz.demo;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

class MyBook {
	private String title;
	private double price;
	public MyBook() {
		System.out.println("********Book类的无参构造*******");
	}
	public MyBook(String title, double price) {
		System.out.println("********Book类的有参构造*******");
		this.title = title;
		this.price = price;
	}
	@Override
	public String toString() {
		return "MyBook [title=" + title + ", price=" + price + "]";
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
}

public class TestClass {

	public static void main(String[] args) throws Exception {
		Class<?> cls = Class.forName("com.cfxyz.demo.MyBook");
		Constructor<?> con = cls.getConstructor(String.class, double.class); //反射调用构造方法
		Object obj = con.newInstance("Java开发", 345.3);
		System.out.println(obj);
		
		Method setMet = cls.getMethod("setTitle", String.class); //反射调用普通方法
		setMet.invoke(obj, "Android开发");
		Method getMet = cls.getMethod("getTitle");
		System.out.println(getMet.invoke(obj));
		System.out.println(obj);
		
		Field titleField = cls.getDeclaredField("title"); //反射调用属性
		titleField.setAccessible(true); //取消封装
		titleField.set(obj, "JSP开发");
		System.out.println(titleField.get(obj));
		System.out.println(obj);
	}

}
