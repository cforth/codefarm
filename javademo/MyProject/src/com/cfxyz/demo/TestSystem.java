package com.cfxyz.demo;

class Member {
	public Member(){
		System.out.println("��������ˣ�������");
	}
	@Override
	protected void finalize() throws Throwable {
		System.out.println("�����ͷ��ˣ�����");
		throw new Exception("�׳��쳣");
	}
}

public class TestSystem {

	public static void main(String[] args) throws Exception{
//		long start = System.currentTimeMillis();
//		@SuppressWarnings("unused")
//		String str = "";
//		for(int x = 0; x < 30000; x ++) {
//			str += x;
//		}
//		long end = System.currentTimeMillis();
//		System.out.println("���β������ѵ�ʱ�䣺" + (end - start));
		@SuppressWarnings("unused")
		Member mem = new Member();
		mem = null; //������쳣
		System.gc(); //�ֹ�gc
	}

}
