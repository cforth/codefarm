package com.cfxyz.demo;

import java.net.Socket;
import java.util.Scanner;

public class HelloClient {

	public static void main(String[] args) throws Exception {
		Socket client = new Socket("localhost", 9999); //���ӷ�������
		//ȡ�ÿͻ��˵��������������󣬱�ʾ���շ������˵������Ϣ
		Scanner scan = new Scanner(client.getInputStream());
		scan.useDelimiter("\n");
		if(scan.hasNext()) {
			System.out.println("����Ӧ���ݡ�" + scan.next());
		}
		System.out.println("�رտͻ�������");
		scan.close();
		client.close();
	}

}
