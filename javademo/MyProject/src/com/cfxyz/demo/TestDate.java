package com.cfxyz.demo;

import java.util.Date;

public class TestDate {

	public static void main(String[] args) {
		long cur = System.currentTimeMillis();
		Date date = new Date(cur);
		System.out.println(date);
		System.out.println(date.getTime());
	}

}
