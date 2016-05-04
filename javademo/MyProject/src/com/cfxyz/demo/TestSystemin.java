package com.cfxyz.demo;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class TestSystemin {

	public static void main(String[] args) throws Exception{
		BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));
		System.out.print("请输入数据：");
		String str = buf.readLine();
		System.out.println("输入的数据是：" + str);
	}

}
