package com.cfxyz.test;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.cfxyz.factory.ServiceFactory;
import com.cfxyz.vo.Emp;

public class TestEmpSplit {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		try {
			Map<String, Object> map = ServiceFactory.getIEmpServiceInstance().list(2, 5, "ename", "");
			int count = (Integer) map.get("empCount");
			System.out.println("Êý¾ÝÁ¿£º" + count);
			List<Emp> all = (List<Emp>) map.get("allEmps");
			Iterator<Emp> iter = all.iterator();
			while(iter.hasNext()) {
				Emp vo = iter.next();
				System.out.println(vo.getEname() + "£¬" + vo.getJob());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
