package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

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


public class TestJDBC {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		//��һ�����������ݿ��������򣬴�ʱ����Ҫʵ��������Ϊ���������Լ��������
		Class.forName(DBDRIVER);
		
		//�ڶ������������ݿ�
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		System.out.println(conn);
		
		//���������������ݿ�
		//���ݸ��£�
		Statement stmt = conn.createStatement(); 
		String sql =" INSERT INTO member (mid, name, birthday, age, note) VALUES "
				+ " (myseq.nextval, '����', TO_DATE('1998-10-10', 'yyyy-mm-dd'), 17, '�Ǹ���') " ;
		int len;
		for(int x = 0; x < 30; x++) {
			len = stmt.executeUpdate(sql) ; //ִ�и���
			System.out.println("Ӱ��������У�" + len);
		}
		
		//�����޸ģ�
		sql ="UPDATE member SET name = '����',birthday=SYSDATE, age=30 WHERE mid IN(3,5,7,9,11,13,15,17) " ;
		len = stmt.executeUpdate(sql) ; 
		System.out.println("Ӱ��������У�" + len);	
		
		//����ɾ����
		sql ="DELETE FROM member WHERE mid IN(10, 20, 30)";
		len = stmt.executeUpdate(sql) ; 
		System.out.println("Ӱ��������У�" + len);
		
		//���ݲ�ѯ��
		sql = "SELECT mid, name, birthday, age, note FROM member";
		ResultSet rs = stmt.executeQuery(sql) ; 
		while(rs.next()) { //ѭ��ȡ�����ص�ÿһ������
			int mid = rs.getInt("mid");
			String name = rs.getString("name");
			int age = rs.getInt("age");
			Date birthday = rs.getDate("birthday");
			String note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//���Ĳ����ر����ݿ�
		rs.close(); //��ѡ
		stmt.close();  //��ѡ
		conn.close();
	}

}