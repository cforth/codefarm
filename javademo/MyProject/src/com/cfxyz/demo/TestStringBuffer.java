package com.cfxyz.demo;

public class TestStringBuffer {

	public static void main(String[] args) {
		//StringBuffer�಻��ֱ�Ӹ�ֵ
		StringBuffer buf = new StringBuffer("helloworld");
		buf.insert(0, "cf");
		System.out.println(buf);
		System.out.println(buf.reverse());
	}

}
