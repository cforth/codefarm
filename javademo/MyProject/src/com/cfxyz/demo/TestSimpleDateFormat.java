package com.cfxyz.demo;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TestSimpleDateFormat {

	public static void main(String[] args) throws Exception {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		String str = sdf.format(date); //日期型数据变为字符串
		System.out.println(str);
		str = "2001-11-11 11:11:11.111";
		date = sdf.parse(str);  //字符串变为日期型数据
		System.out.println(date);
		
		Calendar cal = Calendar.getInstance();
		StringBuffer buf = new StringBuffer();
		buf.append(cal.get(Calendar.YEAR)).append("-");
		buf.append(cal.get(Calendar.MONTH)+1).append("-");
		buf.append(cal.get(Calendar.DAY_OF_MONTH)).append(" ");
		buf.append(cal.get(Calendar.HOUR_OF_DAY)).append(":");
		buf.append(cal.get(Calendar.MINUTE)).append(":");
		buf.append(cal.get(Calendar.SECOND));
		System.out.println(buf);
	}

}
