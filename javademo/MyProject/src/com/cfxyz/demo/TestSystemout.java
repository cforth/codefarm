package com.cfxyz.demo;

import java.io.IOException;
import java.io.OutputStream;
import java.util.function.Consumer;

public class TestSystemout {

	public static void main(String[] args) throws IOException {
		OutputStream out = System.out;
		out.write("Hello".getBytes());
		Consumer<String> con = System.out :: println; //函数式接口
		con.accept("Hello!");
	}

}
