interface Fruit { //接口定义
	public void eat();
}

class Factory { //使用反射实现工厂类，从而不使用new关键字来获得解耦合
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
		System.out.println("吃苹果！");
	}
}

class Orange implements Fruit {
	@Override
	public void eat() {
		System.out.println("吃橘子！");
	}
}

public class TestFactory {

	public static void main(String[] args) {
		Fruit apple = Factory.getInstance("Apple");
		apple.eat();
		Fruit orange = Factory.getInstance("Orange");
		orange.eat();
	}

}
