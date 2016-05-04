package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

//测试数据先运行TestJDBC

public class testPreparedStatement {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		String name = "Mr'SMITH";
		Date birthday = new Date();
		int age = 18;
		String note = "是个外国人";
		//第一步：加载数据库驱动程序，此时不需要实例化，因为会由容器自己负责管理
		Class.forName(DBDRIVER);
		
		//第二步：连接数据库
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);

		//第三步：操作数据库
		//增加数据,SQL语句如果要换行，前后加空格
		String sql =" INSERT INTO member (mid, name, birthday, age, note) VALUES "
				+ " (myseq.nextval, ?, ?, ?, ?) " ;
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, name);
		stmt.setDate(2, new java.sql.Date(birthday.getTime()));  //Date必须进行转换
		stmt.setInt(3, age);
		stmt.setString(4, note);
		int len = stmt.executeUpdate() ; //执行更新
		System.out.println("影响的数据行：" + len);
		
		//查询数据
		sql ="SELECT mid, name, birthday, age, note FROM member ORDER BY mid" ;
		stmt = conn.prepareStatement(sql); 
		ResultSet rs = stmt.executeQuery() ;  //执行查询
		while(rs.next()) { //循环取出返回的每一行数据
			int mid = rs.getInt("mid");
			name = rs.getString("name");
			age = rs.getInt("age");
			birthday = rs.getDate("birthday");
			note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//模糊查询
		String keyWord = "李";
		sql ="SELECT mid, name, birthday, age, note FROM member WHERE name LIKE ?" ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+keyWord+"%");
		rs = stmt.executeQuery() ;  //执行查询
		while(rs.next()) { //循环取出返回的每一行数据
			int mid = rs.getInt("mid");
			name = rs.getString("name");
			age = rs.getInt("age");
			birthday = rs.getDate("birthday");
			note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//第四部：关闭连接
		rs.close(); //可选
		stmt.close();  //可选
		conn.close();
	}

}
