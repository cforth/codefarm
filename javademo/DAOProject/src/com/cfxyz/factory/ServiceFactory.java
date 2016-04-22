package com.cfxyz.factory;

import com.cfxyz.service.IEmpService;
import com.cfxyz.service.impl.EmpServiceImpl;

public class ServiceFactory {
	public static IEmpService getIEmpServiceInstance() {
		return new EmpServiceImpl();
	}
}
