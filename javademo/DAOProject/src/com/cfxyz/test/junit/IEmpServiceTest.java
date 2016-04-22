package com.cfxyz.test.junit;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.junit.Test;

import com.cfxyz.factory.ServiceFactory;
import com.cfxyz.vo.Emp;

import junit.framework.TestCase;

public class IEmpServiceTest {

	@Test
	public void testInsert() {
		Emp vo = new Emp();
		vo.setEmpno(8889);
		vo.setEname("CF");
		vo.setJob("科学家");
		vo.setHiredate(new Date());
		vo.setSal(9000.0);
		vo.setComm(5000.0);
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().insert(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdate() {
		Emp vo = new Emp();
		vo.setEmpno(8889);
		vo.setEname("CF");
		vo.setJob("数学家");
		vo.setHiredate(new Date());
		vo.setSal(8888.0);
		vo.setComm(9999.0);
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().update(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testDelete() {
		Set<Integer> ids = new HashSet<Integer>();
		ids.add(8889);
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().delete(ids));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testGet() {
		try {
			TestCase.assertNotNull(ServiceFactory.getIEmpServiceInstance().get(7369));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testList() {
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().list().size() > 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testListIntIntStringString() {
		try {
			Map<String, Object> map = ServiceFactory.getIEmpServiceInstance().list(2, 5, "ename", "");
			int count = (Integer) map.get("empCount");
			List<Emp> all = (List<Emp>) map.get("allEmps");
			TestCase.assertTrue(count > 0 && all.size() > 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
