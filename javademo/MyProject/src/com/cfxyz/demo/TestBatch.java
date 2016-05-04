package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Arrays;

/*
 * Oracle���ݿ�ű�
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
		conn.setAutoCommit(false); //ȡ���Զ��ύ
		try {
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '����	A')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '����B')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '����	C')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '����	D')");
			stmt.addBatch("INSERT INTO member(mid,name) VALUES (myseq.nextval, '����	E')");
			int result [] = stmt.executeBatch(); //ִ�д���
			System.out.println(Arrays.toString(result));
			conn.commit(); //���û�д��󣬽����ύ
		} catch(Exception e) {
			e.printStackTrace();
			conn.rollback(); //��������쳣����лع�
		}
		conn.close();
	}

}
