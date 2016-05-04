package com.cfxyz.demo;

import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class HelloServer {

	public static void main(String[] args) throws Exception {
		ServerSocket server = new ServerSocket(9999);
		System.out.println("等待客户端连接.....");
		Socket client = server.accept();  //等待客户端连接
		//利用打印流完成输出
		PrintStream out = new PrintStream(client.getOutputStream());
		out.println("Hello World!");
		System.out.println("关闭服务器端连接");
		out.close();
		client.close();
		server.close();
	}

}
