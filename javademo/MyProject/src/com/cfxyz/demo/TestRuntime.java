package com.cfxyz.demo;

public class TestRuntime {

	public static void main(String[] args) throws Exception{
		Runtime run = Runtime.getRuntime();
//		System.out.println("1、MAX=" + run.maxMemory()/1024.0/1024.0 + "M");
//		System.out.println("1、TOTAL=" + run.totalMemory()/1024.0/1024.0 + "M");
//		System.out.println("1、FREE=" + run.freeMemory()/1024.0/1024.0 + "M");
//		String str = "";
//		for(int x = 0; x < 2000; x ++) {
//			str += x;
//		}
//		System.out.println("2、MAX=" + run.maxMemory()/1024.0/1024.0 + "M");
//		System.out.println("2、TOTAL=" + run.totalMemory()/1024.0/1024.0 + "M");
//		System.out.println("2、FREE=" + run.freeMemory()/1024.0/1024.0 + "M");
//		run.gc();
//		System.out.println("3、MAX=" + run.maxMemory()/1024.0/1024.0 + "M");
//		System.out.println("3、TOTAL=" + run.totalMemory()/1024.0/1024.0 + "M");
//		System.out.println("3、FREE=" + run.freeMemory()/1024.0/1024.0 + "M");
//	
		Process pro = run.exec("mspaint.exe");
		Thread.sleep(2000);
		pro.destroy();
	}

}
