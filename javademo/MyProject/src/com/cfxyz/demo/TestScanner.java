package com.cfxyz.demo;

import java.util.Scanner;

public class TestScanner {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in); //׼�����ܼ�����������
		scan.useDelimiter("\n"); //���÷ָ���
		System.out.print("���������ݣ�");
		if(scan.hasNext()){
			System.out.print("������ݣ�" + scan.next());
		}
		scan.close();
	}

}
