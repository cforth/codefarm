package com.cfxyz.demo;

class Member {
	public Member(){
		System.out.println("对象产生了！！！！");
	}
	@Override
	protected void finalize() throws Throwable {
		System.out.println("对象被释放了！！！");
		throw new Exception("抛出异常");
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
//		System.out.println("本次操作花费的时间：" + (end - start));
		@SuppressWarnings("unused")
		Member mem = new Member();
		mem = null; //会产生异常
		System.gc(); //手工gc
	}

}
