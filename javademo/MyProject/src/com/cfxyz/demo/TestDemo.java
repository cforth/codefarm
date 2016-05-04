package com.cfxyz.demo;

class MyThreadTest implements Runnable {
	@Override
	public void run() {
		for(int x = 0; x < 100; x ++) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(Thread.currentThread().getName() + x);
		}
	}
}

public class TestDemo {

	public static void main(String[] args) {
		MyThreadTest mt = new MyThreadTest();
		new Thread(mt, "自己的线程A").start();
		new Thread(mt, "自己的线程B").start();
		new Thread(mt, "自己的线程C").start();
		new Thread(mt, "自己的线程D").start();
		new Thread(mt, "自己的线程E").start();
	}
}
