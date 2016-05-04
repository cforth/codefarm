package com.cfxyz.demo;

//�ڶ���ʵ��,�ӿڷ�ʽ
class MyThread implements Runnable {
	private int ticket = 5;
	
	@Override
	public void run() {
		for (int x = 0; x < 20; x++) {
			this.sale();
		}
	}
	
	public synchronized void sale() { //ͬ������
		if(this.ticket > 0) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(Thread.currentThread().getName() + "��Ʊ��ticket = " + this.ticket--);
		}
	}
}

public class TestThread {

	public static void main(String[] args) {
		MyThread mt = new MyThread();
		new Thread(mt, "Ʊ����A").start();
		new Thread(mt, "Ʊ����B").start();
		new Thread(mt, "Ʊ����C").start();
		new Thread(mt, "Ʊ����D").start();
	}

}
