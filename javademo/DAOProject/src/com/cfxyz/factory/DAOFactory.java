package com.cfxyz.factory;

import java.sql.Connection;

import com.cfxyz.dao.IDeptDAO;
import com.cfxyz.dao.IEmpDAO;
import com.cfxyz.dao.impl.DeptDAOImpl;
import com.cfxyz.dao.impl.EmpDAOImpl;

public class DAOFactory {
	public static IEmpDAO getIEmpDAOInstance(Connection  conn) {
		return new EmpDAOImpl(conn);
	}
	public static IDeptDAO getIDeptDAOInstance(Connection conn) {
		return new DeptDAOImpl(conn);
	}
}
