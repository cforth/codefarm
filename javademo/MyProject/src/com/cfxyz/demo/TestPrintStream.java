package com.cfxyz.demo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;

public class TestPrintStream {

	public static void main(String[] args) throws Exception {
		PrintStream pu = new PrintStream(new FileOutputStream(new File("e:" + File.separator + "test.txt")));
		pu.print("Hello ");
		pu.print("World ");
		pu.println(3 + 34);
		pu.println(23.3 + 33.4);
		pu.close();
	}

}
