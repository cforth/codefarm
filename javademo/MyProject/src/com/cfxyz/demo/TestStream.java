package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class TestStream {

	public static void main(String[] args) throws Exception {
		// 定义要输出的文件路径
		File file = new File("e:" + File.separator + "demo" + File.separator + "test.txt"); 
//		// 1、目录不存在需要先创建目录
//		if(!file.getParentFile().exists()) { //首先判断父目录是否存在
//			file.getParentFile().mkdirs(); //不存在的话创建目录
//		}
//		// 2、使用OutputStream和其子类进行对象的实例化
//		OutputStream output = new FileOutputStream(file, true);
//		// 3、要进行文件内容的输出
//		String str = "好好学习，天天向上\r\n";
//		byte data[] = str.getBytes();
//		output.write(data);;
//		// 4、资源操作一定要进行关闭
//		output.close();
		
		if(file.exists()) {
			InputStream input = new FileInputStream(file);
			byte data[] = new byte [1024];
//			int len = input.read(data);
			int foot = 0;
			int temp = 0;
			while ((temp = input.read()) != -1) {
				data[foot++] = (byte)temp;
			} 
//			System.out.println(new String(data, 0, len));
			System.out.println(new String(data, 0, foot));
			input.close();
		}
	}

}
