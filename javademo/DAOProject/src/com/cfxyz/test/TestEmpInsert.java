package com.cfxyz.test;

import java.util.Date;

import com.cfxyz.factory.ServiceFactory;
import com.cfxyz.vo.Emp;

public class TestEmpInsert {
	public static void main(String[] args) {
		Emp vo = new Emp();
		vo.setEmpno(8889);
		vo.setEname("CF");
		vo.setJob("¿ÆÑ§¼Ò");
		vo.setHiredate(new Date());
		vo.setSal(8888.0);
		vo.setComm(9999.0);
		try {
			System.out.println(ServiceFactory.getIEmpServiceInstance().insert(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
