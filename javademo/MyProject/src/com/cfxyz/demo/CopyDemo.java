package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

/** 模拟DOS系统中的COPY程序
 * 命令行参数  （ 源文件  目标文件）
 */
public class CopyDemo {

	public static void main(String[] args) throws Exception{
		long start = System.currentTimeMillis();
		if(args.length != 2) { //初始化参数不足两位
			System.out.println("命令执行错误！");
			System.exit(1); //程序退出执行
		}
		// 如果输入参数正确了，那么应该进行文件的验证
		File inFile = new File(args[0]); //第一个为源文件路径
		if (!inFile.exists()) { //源文件不存在
			System.out.println("源文件不存在，请确认执行路径。");
			System.exit(1); //程序退出
		}
		// 如果此时源文件正确，那么就需要定义输出文件，同时考虑到输出文件有目录
		File outFile = new File(args[1]);
		if (!outFile.getParentFile().exists()) {
			outFile.getParentFile().mkdirs(); //创建目录
		}
		// 实现文件内容的拷贝
		InputStream input = new FileInputStream(inFile);
		OutputStream output = new FileOutputStream(outFile);
		// 实现文件拷贝
		int temp = 0;  //保存每次读取的个数
		byte data[] = new byte [2048]; // 每次读取2048个字节
		// 将每次读取的数据保存在字节数组里面，并且返回读取的个数
		while((temp = input.read(data)) != -1) {
			output.write(data, 0, temp); //输出数组
		}
		input.close();
		output.close();
		long end = System.currentTimeMillis();
		System.out.println("拷贝完成!\n花费的时间：" + (end - start) + "毫秒");
	}

}
