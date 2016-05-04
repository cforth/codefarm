package com.cfxyz.demo;

import java.util.Scanner;

public class TestScanner {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in); //准备接受键盘输入数据
		scan.useDelimiter("\n"); //设置分隔符
		System.out.print("请输入内容：");
		if(scan.hasNext()){
			System.out.print("输出内容：" + scan.next());
		}
		scan.close();
	}

}
