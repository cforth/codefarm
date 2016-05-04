package com.cfxyz.demo;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

class MyBook {
	private String title;
	private double price;
	public MyBook() {
		System.out.println("********Book����޲ι���*******");
	}
	public MyBook(String title, double price) {
		System.out.println("********Book����вι���*******");
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
		Constructor<?> con = cls.getConstructor(String.class, double.class); //������ù��췽��
		Object obj = con.newInstance("Java����", 345.3);
		System.out.println(obj);
		
		Method setMet = cls.getMethod("setTitle", String.class); //���������ͨ����
		setMet.invoke(obj, "Android����");
		Method getMet = cls.getMethod("getTitle");
		System.out.println(getMet.invoke(obj));
		System.out.println(obj);
		
		Field titleField = cls.getDeclaredField("title"); //�����������
		titleField.setAccessible(true); //ȡ����װ
		titleField.set(obj, "JSP����");
		System.out.println(titleField.get(obj));
		System.out.println(obj);
	}

}
