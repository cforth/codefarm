package com.cfxyz.factory;

import com.cfxyz.service.IDeptService;
import com.cfxyz.service.IEmpService;
import com.cfxyz.service.impl.DeptServiceImpl;
import com.cfxyz.service.impl.EmpServiceImpl;

public class ServiceFactory {
	public static IEmpService getIEmpServiceInstance() {
		return new EmpServiceImpl();
	}
	public static IDeptService getIDeptServiceInstance() {
		return new DeptServiceImpl();
	}
}
