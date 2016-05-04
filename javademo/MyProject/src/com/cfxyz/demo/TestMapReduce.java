package com.cfxyz.demo;

import java.util.ArrayList;
import java.util.DoubleSummaryStatistics;
import java.util.List;

class ShopCar {
	private String pname;
	private int amount;
	private double price;
	public ShopCar(String pname, double price, int amount) {
		this.pname = pname;
		this.amount = amount;
		this.price = price;
	}
	public String getPname() {
		return this.pname;
	}
	public int getAmount() {
		return this.amount;
	}
	public double getPrice() {
		return this.price;
	}
}

public class TestMapReduce {

	public static void main(String[] args) {
		List<ShopCar> all = new ArrayList<ShopCar>();
		all.add(new ShopCar("Java����", 34.5, 20));
		all.add(new ShopCar("Jsp����", 56.5, 50));
		all.add(new ShopCar("Ocale����", 99.5, 100));
		double s = all.stream()
					.map((x)->x.getAmount() * x.getPrice())
					.reduce((sum, m)-> sum+m).get();
		System.out.println("�ܼƻ���:" + s);
		
		DoubleSummaryStatistics dss = all.stream()
			.mapToDouble((sc)->sc.getAmount() * sc.getPrice())
			.summaryStatistics();
		System.out.println("��Ʒ����:" + dss.getCount());
		System.out.println("ƽ������:" + dss.getAverage());
		System.out.println("��󻨷�:" + dss.getMax());
		System.out.println("���»���:" + dss.getMin());
	}

}
