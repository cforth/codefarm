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
		all.add(new ShopCar("Java开发", 34.5, 20));
		all.add(new ShopCar("Jsp开发", 56.5, 50));
		all.add(new ShopCar("Ocale开发", 99.5, 100));
		double s = all.stream()
					.map((x)->x.getAmount() * x.getPrice())
					.reduce((sum, m)-> sum+m).get();
		System.out.println("总计花费:" + s);
		
		DoubleSummaryStatistics dss = all.stream()
			.mapToDouble((sc)->sc.getAmount() * sc.getPrice())
			.summaryStatistics();
		System.out.println("商品数量:" + dss.getCount());
		System.out.println("平均花费:" + dss.getAverage());
		System.out.println("最大花费:" + dss.getMax());
		System.out.println("最下花费:" + dss.getMin());
	}

}
