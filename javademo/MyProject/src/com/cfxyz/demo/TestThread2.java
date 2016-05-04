package com.cfxyz.demo;

/**
 * 生产者 消费者模型
 * 每次生产一个，取出一个
 * 需要解决同步和重复问题。
 */

class Info {
	private String title;
	private String content;
	private boolean flag = true;
	// flag = true:表示可以生产，但不可以取走
	// flag = false:表示可以取走，但不可以生产
	public synchronized void set(String title, String content) { //解决同步问题
		//重复进入到set()方法里面，发现不能生产，所以要等待
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
		this.flag = false; //修改生产标记
		super.notify();//唤醒其它等待线程
	}
	public synchronized void get() { //解决同步问题
		// 还没生产
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
