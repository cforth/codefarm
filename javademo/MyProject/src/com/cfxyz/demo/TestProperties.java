package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

/**
 * 资源文件操作
 * @author Administrator
 *
 */
public class TestProperties {

	public static void main(String[] args) throws Exception {
		Properties pro = new Properties();
		pro.setProperty("cd", "算法");
		pro.setProperty("csd", "东方闪电");
		System.out.println(pro.getProperty("cd"));
		System.out.println(pro.getProperty("cdsdd", "没有此属性"));
		pro.store(new FileOutputStream(new File("e:" + File.separator + "test.properties")), "info");
	
		Properties pros = new Properties();
		pros.load(new FileInputStream(new File("e:" + File.separator + "test.properties")));
		System.out.println(pros.getProperty("cd"));
	}

}
