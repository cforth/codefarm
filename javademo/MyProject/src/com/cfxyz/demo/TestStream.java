package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class TestStream {

	public static void main(String[] args) throws Exception {
		// ����Ҫ������ļ�·��
		File file = new File("e:" + File.separator + "demo" + File.separator + "test.txt"); 
//		// 1��Ŀ¼��������Ҫ�ȴ���Ŀ¼
//		if(!file.getParentFile().exists()) { //�����жϸ�Ŀ¼�Ƿ����
//			file.getParentFile().mkdirs(); //�����ڵĻ�����Ŀ¼
//		}
//		// 2��ʹ��OutputStream����������ж����ʵ����
//		OutputStream output = new FileOutputStream(file, true);
//		// 3��Ҫ�����ļ����ݵ����
//		String str = "�ú�ѧϰ����������\r\n";
//		byte data[] = str.getBytes();
//		output.write(data);;
//		// 4����Դ����һ��Ҫ���йر�
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
