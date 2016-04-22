package com.cfxyz.dbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * ����ר�Ÿ������ݿ��������رղ�������ʵ�����������ʱ����ζ��Ҫ�������ݿ�Ŀ���
 * �����ڱ���Ĺ��췽����Ҫ�������ݿ��������������ݿ�����ȡ��
 *
 */
public class DatabaseConnection {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	private Connection conn = null;
	
	/**
	 * �ڹ��췽������Ϊconn�������ʵ����������ֱ��ȡ�����ݿ�����Ӷ���
	 * �������еĲ������ǻ������ݿ���ɵģ�������ݿ�ȡ�ò������ӣ���ô���в���������ֹͣ��
	 */
	public DatabaseConnection() {
		try {
			Class.forName(DBDRIVER);
			this.conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		} catch (Exception e) { //�˴���Ȼ���쳣�������׳����岻��
			e.printStackTrace();
		}
	}
	
	/**
	 * ȡ��һ�����ݿ�����Ӷ���
	 */
	public Connection getConnection() {
		return this.conn ;
	}
	
	/**
	 * �������ݿ�Ĺر�
	 */
	public void close() {
		if(this.conn != null) { //��ʾ���ڴ������Ӷ���
			try {
				this.conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
