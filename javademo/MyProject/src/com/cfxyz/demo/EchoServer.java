package com.cfxyz.demo;

import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

class EchoThread implements Runnable {
	private Socket client;
	public EchoThread(Socket client) {
		this.client = client;
	}
	
	@Override
	public void run() {
		try {
			// �õ��ͻ������������Լ���ͻ���������ݵĶ���
			Scanner scan = new Scanner(client.getInputStream());
			PrintStream out = new PrintStream(client.getOutputStream());
			boolean flag = true;
			while(flag) {
				if(scan.hasNext()) {
					String str = scan.next().trim(); //�õ��ͻ��˷��͵�����
					if(str.equalsIgnoreCase("byebye")) {
						out.println("�ݰݣ��´��ٻᣡ"); //����Ҫ����
						flag = false;
					} else {   //��Ӧ������Ϣ
						out.println("ECHO : " + str);
					}
				}
			}
			System.out.println("�ͻ��˹ر�����.....");
			scan.close();
			out.close();
			client.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}

public class EchoServer {

	public static void main(String[] args) throws Exception {
		ServerSocket server = new ServerSocket(9999);
		System.out.println("�ȴ�����.....");
		boolean flag = true;
		while(flag) {
			Socket client = server.accept();   //���ӿͻ���
			new Thread(new EchoThread(client)).start();
			System.out.println("�ͻ����Ѿ�����.....");
		}
		server.close();
	}

}
