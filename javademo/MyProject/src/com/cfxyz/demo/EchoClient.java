package com.cfxyz.demo;

import java.io.PrintStream;
import java.net.Socket;
import java.util.Scanner;

public class EchoClient {

	public static void main(String[] args) throws Exception {
		Socket client = new Socket("localhost", 9999); //连接服务端
		Scanner input = new Scanner(System.in);
		Scanner scan = new Scanner(client.getInputStream());
		input.useDelimiter("\n");
		scan.useDelimiter("\n");
		PrintStream out = new PrintStream(client.getOutputStream());
		boolean flag = true;
		while(flag) {
			System.out.print("请输入要发送的数据:");
			if(input.hasNext()) {
				String str = input.next().trim();
				out.println(str); //发送服务器端数据
				if(str.equalsIgnoreCase("byebye")) {
					flag = false; //结束循环
				}
				if(scan.hasNext()) {
					System.out.println(scan.next());
				}
			}
		}
		input.close();
		scan.close();
		out.close();
		client.close();
	}

}
