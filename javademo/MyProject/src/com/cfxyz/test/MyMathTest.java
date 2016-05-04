package com.cfxyz.test;

import org.junit.Test;

import com.cfxyz.util.MyMath;

import junit.framework.TestCase;

public class MyMathTest {

	@Test
	public void testDiv() {
		try {
			TestCase.assertEquals(MyMath.mydiv(10,2), 5);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
