package com.cfxyz.demo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TestRegex {

	public static void main(String[] args) throws Exception {
		String strDate = "2016-04-01";
		String regexDate = "\\d{4}-\\d{2}-\\d{2}";
		System.out.println(strDate.matches(regexDate));
		if(strDate.matches(regexDate)) {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(strDate);
			System.out.println(date);
		}
		
		String strPhoneNum = "(0513)-86899596";
		String regexPhoneNum = "((\\(\\d{3,4}\\)-)|(\\d{3,4}-))?\\d{7,8}";
		System.out.println(strPhoneNum.matches(regexPhoneNum));
		
		String strEmail = "sd_f@gmail.com";  //字母数字下划线组成
		String regexEmail = "\\w+@\\w+\\.\\w+";
		System.out.println(strEmail.matches(regexEmail));
	}

}
