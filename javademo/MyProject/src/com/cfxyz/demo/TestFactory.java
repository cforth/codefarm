package com.cfxyz.demo;

interface Fruit { //�ӿڶ���
	public void eat();
}

class Factory { //ʹ�÷���ʵ�ֹ����࣬�Ӷ���ʹ��new�ؼ�������ý����
	public static Fruit getInstance(String className) {
		Fruit f = null;
		try {
			f = (Fruit) Class.forName(className).newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}

class Apple implements Fruit {
	@Override
	public void eat() {
		System.out.println("��ƻ����");
	}
}

class Orange implements Fruit {
	@Override
	public void eat() {
		System.out.println("�����ӣ�");
	}
}

public class TestFactory {

	public static void main(String[] args) {
		Fruit apple = Factory.getInstance("com.cfxyz.demo.Apple");
		apple.eat();
		Fruit orange = Factory.getInstance("com.cfxyz.demo.Orange");
		orange.eat();
	}

}
