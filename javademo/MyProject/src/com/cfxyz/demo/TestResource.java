package com.cfxyz.demo;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

public class TestResource {

	public static void main(String[] args) {
		@SuppressWarnings("unused")
		Locale locUS = new Locale("en", "US");
		Locale locCN = new Locale("zh", "CN");
		ResourceBundle rb = ResourceBundle.getBundle("Messages", locCN);
		String str = rb.getString("wel.msg");
		System.out.println(MessageFormat.format(str, "CF"));
	}

}
