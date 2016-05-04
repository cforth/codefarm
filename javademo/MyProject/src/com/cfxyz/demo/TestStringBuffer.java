package com.cfxyz.demo;

public class TestStringBuffer {

	public static void main(String[] args) {
		//StringBuffer类不能直接赋值
		StringBuffer buf = new StringBuffer("helloworld");
		buf.insert(0, "cf");
		System.out.println(buf);
		System.out.println(buf.reverse());
	}

}
