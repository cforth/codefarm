package com.cfxyz.demo;

import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class HelloServer {

	public static void main(String[] args) throws Exception {
		ServerSocket server = new ServerSocket(9999);
		System.out.println("�ȴ��ͻ�������.....");
		Socket client = server.accept();  //�ȴ��ͻ�������
		//���ô�ӡ��������
		PrintStream out = new PrintStream(client.getOutputStream());
		out.println("Hello World!");
		System.out.println("�رշ�����������");
		out.close();
		client.close();
		server.close();
	}

}
