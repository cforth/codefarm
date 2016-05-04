package com.cfxyz.demo;

/**
 * ������ ������ģ��
 * ÿ������һ����ȡ��һ��
 * ��Ҫ���ͬ�����ظ����⡣
 */

class Info {
	private String title;
	private String content;
	private boolean flag = true;
	// flag = true:��ʾ������������������ȡ��
	// flag = false:��ʾ����ȡ�ߣ�������������
	public synchronized void set(String title, String content) { //���ͬ������
		//�ظ����뵽set()�������棬���ֲ�������������Ҫ�ȴ�
		if(this.flag == false) {
			try {
				super.wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		this.title = title;
		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		this.content = content;
		this.flag = false; //�޸��������
		super.notify();//���������ȴ��߳�
	}
	public synchronized void get() { //���ͬ������
		// ��û����
		if(this.flag == true) {
			try {
				super.wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		try {
			Thread.sleep(100);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println(this.title + "-" + this.content);
		this.flag = true;
		super.notify();
	}
}

class Productor implements Runnable {
	private Info info;
	public Productor(Info info) {
		this.info = info;
	}
	@Override
	public void run() {
		for (int x = 0; x < 100; x++) {
			if(x % 2 == 0) {
				this.info.set("AAA", "111");
			} else {
				this.info.set("BBB", "222");
			}
		} 
			
	}
}

class Customer implements Runnable {
	private Info info ;
	public Customer(Info info) {
		this.info = info;
	}
	@Override
	public void run() {
		for(int x = 0; x < 100 ; x++) {
			this.info.get();
		}
	}
}

public class TestThread2 {

	public static void main(String[] args) {
		Info info = new Info();
		new Thread(new Productor(info)).start();
		new Thread(new Customer(info)).start();
	}

}
