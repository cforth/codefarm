package com.cfxyz.demo;

import java.net.Socket;
import java.util.Scanner;

public class HelloClient {

	public static void main(String[] args) throws Exception {
		Socket client = new Socket("localhost", 9999); //连接服务器端
		//取得客户端的输入数据流对象，表示接收服务器端的输出信息
		Scanner scan = new Scanner(client.getInputStream());
		scan.useDelimiter("\n");
		if(scan.hasNext()) {
			System.out.println("【回应数据】" + scan.next());
		}
		System.out.println("关闭客户端连接");
		scan.close();
		client.close();
	}

}
