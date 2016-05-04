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
		new Thread(mt, "�Լ����߳�A").start();
		new Thread(mt, "�Լ����߳�B").start();
		new Thread(mt, "�Լ����߳�C").start();
		new Thread(mt, "�Լ����߳�D").start();
		new Thread(mt, "�Լ����߳�E").start();
	}
}
