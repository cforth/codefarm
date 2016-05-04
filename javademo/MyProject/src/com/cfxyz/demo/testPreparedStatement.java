package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

//��������������TestJDBC

public class testPreparedStatement {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		String name = "Mr'SMITH";
		Date birthday = new Date();
		int age = 18;
		String note = "�Ǹ������";
		//��һ�����������ݿ��������򣬴�ʱ����Ҫʵ��������Ϊ���������Լ��������
		Class.forName(DBDRIVER);
		
		//�ڶ������������ݿ�
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);

		//���������������ݿ�
		//��������,SQL������Ҫ���У�ǰ��ӿո�
		String sql =" INSERT INTO member (mid, name, birthday, age, note) VALUES "
				+ " (myseq.nextval, ?, ?, ?, ?) " ;
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, name);
		stmt.setDate(2, new java.sql.Date(birthday.getTime()));  //Date�������ת��
		stmt.setInt(3, age);
		stmt.setString(4, note);
		int len = stmt.executeUpdate() ; //ִ�и���
		System.out.println("Ӱ��������У�" + len);
		
		//��ѯ����
		sql ="SELECT mid, name, birthday, age, note FROM member ORDER BY mid" ;
		stmt = conn.prepareStatement(sql); 
		ResultSet rs = stmt.executeQuery() ;  //ִ�в�ѯ
		while(rs.next()) { //ѭ��ȡ�����ص�ÿһ������
			int mid = rs.getInt("mid");
			name = rs.getString("name");
			age = rs.getInt("age");
			birthday = rs.getDate("birthday");
			note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//ģ����ѯ
		String keyWord = "��";
		sql ="SELECT mid, name, birthday, age, note FROM member WHERE name LIKE ?" ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+keyWord+"%");
		rs = stmt.executeQuery() ;  //ִ�в�ѯ
		while(rs.next()) { //ѭ��ȡ�����ص�ÿһ������
			int mid = rs.getInt("mid");
			name = rs.getString("name");
			age = rs.getInt("age");
			birthday = rs.getDate("birthday");
			note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//���Ĳ����ر�����
		rs.close(); //��ѡ
		stmt.close();  //��ѡ
		conn.close();
	}

}
