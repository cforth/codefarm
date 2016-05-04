package com.cfxyz.demo;

//第二种实现,接口方式
class MyThread implements Runnable {
	private int ticket = 5;
	
	@Override
	public void run() {
		for (int x = 0; x < 20; x++) {
			this.sale();
		}
	}
	
	public synchronized void sale() { //同步方法
		if(this.ticket > 0) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(Thread.currentThread().getName() + "卖票，ticket = " + this.ticket--);
		}
	}
}

public class TestThread {

	public static void main(String[] args) {
		MyThread mt = new MyThread();
		new Thread(mt, "票贩子A").start();
		new Thread(mt, "票贩子B").start();
		new Thread(mt, "票贩子C").start();
		new Thread(mt, "票贩子D").start();
	}

}
