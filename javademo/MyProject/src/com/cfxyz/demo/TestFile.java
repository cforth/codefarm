package com.cfxyz.demo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestFile {

	public static void main(String[] args) throws Exception{
		//�г�������Ŀ¼�е��ļ�
		getTime();
		
		StringBuffer str = new StringBuffer();
		print(new File("d:" + File.separator), str, 0);
		writeFile(new File("F:" + File.separator + "demo" + File.separator + "test.txt"), str);
		
		getTime();
	}
	
	public static void print(File readfile, StringBuffer str, int level) throws Exception {
		for (int x = 0; x < level; x++) {
			str.append("|\t");
		}
		str.append("|-");
		str.append(readfile.getName() + "\t\t" 
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(readfile.lastModified())) + "\t\t"
				+ (readfile.isDirectory() ? "�ļ���" : "�ļ�") + "\t\t"
				+ (readfile.isDirectory() ? "\r\n" : (new BigDecimal((double)readfile.length()/1024/1024).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_UP)) + "M\r\n"));
		
		if(readfile.isDirectory()) {
			level++;
			File result[] = readfile.listFiles();
			if(result != null) {
				for(int x = 0; x < result.length; x ++) {
					print(result[x], str, level);
				}
			}
		}
	}
	
	public static void writeFile(File file, StringBuffer str) throws Exception {
		// 1��Ŀ¼��������Ҫ�ȴ���Ŀ¼
		if(!file.getParentFile().exists()) { //�����жϸ�Ŀ¼�Ƿ����
			file.getParentFile().mkdirs(); //�����ڵĻ�����Ŀ¼
		}
		// 2��ʹ��OutputStream����������ж����ʵ����
		Writer output = new PrintWriter(new FileOutputStream(file, true));
		// 3��Ҫ�����ļ����ݵ����
		output.write(str.toString());
		// 4����Դ����һ��Ҫ���йر�
		output.close();
	}
	
	public static void getTime() {
		Date date = new Date();
		SimpleDateFormat start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		System.out.println(start.format(date));	
	}

}