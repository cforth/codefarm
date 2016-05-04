package com.cfxyz.demo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

class PrintUtil {  //实现专用的输出
	private OutputStream output;
	
	public PrintUtil(OutputStream output) {
		this.output = output;
	}
	
	public void print(String x) {
		try {
			this.output.write(x.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void print(int x) {
		this.print(String.valueOf(x));
	}
	
	public void print(double x) {
		this.print(String.valueOf(x));
	}
	
	public void println(String x) {
		this.print(x.concat("\n"));
	}
	
	public void println(int x) {
		this.println(String.valueOf(x));
	}
	
	public void println(double x) {
		this.println(String.valueOf(x));
	}
	
	public void close() {
		try {
			this.output.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

public class TestPrint {

	public static void main(String[] args) throws Exception{
		PrintUtil pu = new PrintUtil(new FileOutputStream(new File("e:" + File.separator + "test.txt")));
		pu.print("Hello ");
		pu.print("World ");
		pu.print(3 + 34);
		pu.print(23.3 + 33.4);
		pu.close();
	}

}
