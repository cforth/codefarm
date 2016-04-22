package com.cfxyz.dbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 本类专门负责数据库的连接与关闭操作，在实例化本类对象时就意味着要进行数据库的开发
 * 所以在本类的构造方法里要进行数据库驱动加载与数据库连接取得
 *
 */
public class DatabaseConnection {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	private Connection conn = null;
	
	/**
	 * 在构造方法里面为conn对象进行实例化，可以直接取得数据库的连接对象
	 * 由于所有的操作都是基于数据库完成的，如果数据库取得不到连接，那么所有操作都可以停止了
	 */
	public DatabaseConnection() {
		try {
			Class.forName(DBDRIVER);
			this.conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		} catch (Exception e) { //此处虽然有异常，但是抛出意义不大
			e.printStackTrace();
		}
	}
	
	/**
	 * 取得一个数据库的连接对象
	 */
	public Connection getConnection() {
		return this.conn ;
	}
	
	/**
	 * 负责数据库的关闭
	 */
	public void close() {
		if(this.conn != null) { //表示现在存在连接对象
			try {
				this.conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
