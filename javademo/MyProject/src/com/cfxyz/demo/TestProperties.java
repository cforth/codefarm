package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

/**
 * ��Դ�ļ�����
 * @author Administrator
 *
 */
public class TestProperties {

	public static void main(String[] args) throws Exception {
		Properties pro = new Properties();
		pro.setProperty("cd", "�㷨");
		pro.setProperty("csd", "��������");
		System.out.println(pro.getProperty("cd"));
		System.out.println(pro.getProperty("cdsdd", "û�д�����"));
		pro.store(new FileOutputStream(new File("e:" + File.separator + "test.properties")), "info");
	
		Properties pros = new Properties();
		pros.load(new FileInputStream(new File("e:" + File.separator + "test.properties")));
		System.out.println(pros.getProperty("cd"));
	}

}
