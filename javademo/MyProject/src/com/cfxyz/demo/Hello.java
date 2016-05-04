package com.cfxyz.demo;

class Foo {
	public Foo(Object x) {
		System.out.println(x);
	}
}

public class Hello {

	public static void main(String[] args) {
		int x = 0 ;
		Object y = null;
		Integer xxx = new Integer(x);
		Foo fx = new Foo(xxx);
		Foo fy = new Foo(y);

	}

}
