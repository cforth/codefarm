package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Arrays;

/*
 * Oracle数据库脚本
DROP TABLE member PURGE ;
DROP SEQUENCE myseq ;
CREATE SEQUENCE myseq ;
CREATE TABLE member (
    mid         NUMBER,
    name        VARCHAR2(20),
    birthday    DATE DEFAULT SYSDATE ,
    age         NUMBER(3),
    note        CLOB,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);
 */

public class TestBatch {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		Class.forName(DBDRIVER);
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		Statement stmt = conn.createStatement();
		conn.setAutoCommit(false); //取消自动提交
		try {
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '测试	A')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '测试B')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '测试	C')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '测试	D')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '测试	E')");
			int result [] = stmt.executeBatch(); //执行处理
			System.out.println(Arrays.toString(result));
			conn.commit(); //如果没有错误，进行提交
		} catch(Exception e) {
			e.printStackTrace();
			conn.rollback(); //如果出现异常则进行回滚
		}
		conn.close();
	}

}
