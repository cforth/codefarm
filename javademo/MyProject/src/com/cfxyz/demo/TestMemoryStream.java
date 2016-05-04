package com.cfxyz.demo;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

public class TestMemoryStream {

	public static void main(String[] args) throws Exception {
		File fileA = new File("E:" + File.separator + "infoa.txt");
		File fileB = new File("E:" + File.separator + "infob.txt");
		InputStream inputA = new FileInputStream(fileA);
		InputStream inputB = new FileInputStream(fileB);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		int temp = 0;
		while((temp = inputA.read()) != -1) {
			output.write(temp);
		}
		while((temp = inputB.read()) != -1) {
			output.write(temp);
		}
		byte data[] = output.toByteArray();
		System.out.println(new String(data));
		inputA.close();
		inputB.close();
		output.close();
	} 

}
