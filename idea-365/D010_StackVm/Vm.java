package com.cfxyz.newvm;

import java.util.Arrays;
import java.util.Stack;

public class Vm {
	public int here; //词典中空白位的开始地址
	public int last; //词典中最新一个词的词头地址
	public int ip; //IP指针，指向正在执行的词的地址
	public int soureP; //静态代码指针，指向静态代码的空白位的开始地址
	public int[] memory; //静态代码域+词典域
	public int sourceSize = 1000; //静态代码域长度
	public int dictSize = 1000 ; //词典长度
	
	public Stack<Integer> returnStack; //返回栈
	public Stack<Integer> paramStack; //算术栈

	public Vm() {
		this.soureP = 0 ; //静态代码指针初始化
		this.here = sourceSize ; //词典指针初始化
		this.last = this.here ; //词典空白位开始地址指向空白词典头部
		this.ip = 0 ; //IP指针指向静态代码域
		this.memory = new int[sourceSize + dictSize];
		this.returnStack = new Stack<Integer>();
		this.paramStack = new Stack<Integer>();
	}

	public void setValue(int value) {
		this.memory[this.here] = value ;
	}

	@Override
	public String toString() {
		int[] source = new int[this.sourceSize];
		for(int x = 0 ; x < this.sourceSize; x ++) {
			source[x] = this.memory[x] ;
		}
		int[] dict = new int[this.dictSize];
		for(int x = 0; x <this.dictSize; x++) {
			dict[x] = this.memory[this.sourceSize + x];
		}
		
		return  "IP指针 = " + this.ip
				+ "\n静态代码指针 = " + this.soureP
				+ "\n词典指针 = " + this.here 
				+ "\n词头地址 = " + this.last 
				+ "\n算术栈  = " + this.paramStack
				+ "\n返回栈 = " + this.returnStack
				+ "\n静态代码 = " + Arrays.toString(source)
				+ "\n词典内存 = " + Arrays.toString(dict);
	}
}
