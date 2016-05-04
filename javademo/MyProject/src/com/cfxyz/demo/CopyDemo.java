package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

/** ģ��DOSϵͳ�е�COPY����
 * �����в���  �� Դ�ļ�  Ŀ���ļ���
 */
public class CopyDemo {

	public static void main(String[] args) throws Exception{
		long start = System.currentTimeMillis();
		if(args.length != 2) { //��ʼ������������λ
			System.out.println("����ִ�д���");
			System.exit(1); //�����˳�ִ��
		}
		// ������������ȷ�ˣ���ôӦ�ý����ļ�����֤
		File inFile = new File(args[0]); //��һ��ΪԴ�ļ�·��
		if (!inFile.exists()) { //Դ�ļ�������
			System.out.println("Դ�ļ������ڣ���ȷ��ִ��·����");
			System.exit(1); //�����˳�
		}
		// �����ʱԴ�ļ���ȷ����ô����Ҫ��������ļ���ͬʱ���ǵ�����ļ���Ŀ¼
		File outFile = new File(args[1]);
		if (!outFile.getParentFile().exists()) {
			outFile.getParentFile().mkdirs(); //����Ŀ¼
		}
		// ʵ���ļ����ݵĿ���
		InputStream input = new FileInputStream(inFile);
		OutputStream output = new FileOutputStream(outFile);
		// ʵ���ļ�����
		int temp = 0;  //����ÿ�ζ�ȡ�ĸ���
		byte data[] = new byte [2048]; // ÿ�ζ�ȡ2048���ֽ�
		// ��ÿ�ζ�ȡ�����ݱ������ֽ��������棬���ҷ��ض�ȡ�ĸ���
		while((temp = input.read(data)) != -1) {
			output.write(data, 0, temp); //�������
		}
		input.close();
		output.close();
		long end = System.currentTimeMillis();
		System.out.println("�������!\n���ѵ�ʱ�䣺" + (end - start) + "����");
	}

}
