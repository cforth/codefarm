package com.cfxyz.demo;

import java.util.ArrayList;
import java.util.List;

public class TestArrayList {

	public static void main(String[] args) {
		List<String> all = new ArrayList<String>();
		System.out.println("List���ȣ�" + all.size() + "���Ƿ�Ϊ�գ�" + all.isEmpty());
		all.add("Hello!!!");
		all.add("Hello!!!");
		all.add("Hello!!!");
		all.add("World!!!");
		System.out.println("List���ȣ�" + all.size() + "���Ƿ�Ϊ�գ�" + all.isEmpty());
		for(int x = 0; x < all.size(); x ++) {
			System.out.println(all.get(x));
		}
	}

}
