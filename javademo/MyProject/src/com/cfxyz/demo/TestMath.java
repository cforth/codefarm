package com.cfxyz.demo;

import java.math.BigInteger;
import java.util.Random;

@SuppressWarnings("unused")
public class TestMath {

	public static void main(String[] args) {
//		System.out.println(Math.E);
//		System.out.println(Math.PI);
//		System.out.println(Math.round(2.5)); //��������
//		System.out.println(Math.round(-2.5)); //��������
//		Random rand = new Random();
//		for(int x = 0; x < 10; x++) {
//			System.out.print(rand.nextInt(100) + "��");
//		}
		BigInteger bigA = new BigInteger("234324234324324234324");
		BigInteger bigB = new BigInteger("2345435348894784");
		System.out.println("�ӷ�������" + bigA.add(bigB));
		System.out.println("����������" + bigA.subtract(bigB));
		System.out.println("�˷�������" + bigA.multiply(bigB));
		System.out.println("����������" + bigA.divide(bigB));
	}

}
