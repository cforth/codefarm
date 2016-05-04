package com.cfxyz.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

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


public class TestJDBC {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		//第一步：加载数据库驱动程序，此时不需要实例化，因为会由容器自己负责管理
		Class.forName(DBDRIVER);
		
		//第二步：连接数据库
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		System.out.println(conn);
		
		//第三步：操作数据库
		//数据更新：
		Statement stmt = conn.createStatement(); 
		String sql =" INSERT INTO member (mid, name, birthday, age, note) VALUES "
				+ " (myseq.nextval, '张三', TO_DATE('1998-10-10', 'yyyy-mm-dd'), 17, '是个人') " ;
		int len;
		for(int x = 0; x < 30; x++) {
			len = stmt.executeUpdate(sql) ; //执行更新
			System.out.println("影响的数据行：" + len);
		}
		
		//数据修改：
		sql ="UPDATE member SET name = '李四',birthday=SYSDATE, age=30 WHERE mid IN(3,5,7,9,11,13,15,17) " ;
		len = stmt.executeUpdate(sql) ; 
		System.out.println("影响的数据行：" + len);	
		
		//数据删除：
		sql ="DELETE FROM member WHERE mid IN(10, 20, 30)";
		len = stmt.executeUpdate(sql) ; 
		System.out.println("影响的数据行：" + len);
		
		//数据查询：
		sql = "SELECT mid, name, birthday, age, note FROM member";
		ResultSet rs = stmt.executeQuery(sql) ; 
		while(rs.next()) { //循环取出返回的每一行数据
			int mid = rs.getInt("mid");
			String name = rs.getString("name");
			int age = rs.getInt("age");
			Date birthday = rs.getDate("birthday");
			String note = rs.getString("note");
			System.out.println(mid + ", " + name + ", " + age + ", " + birthday + ", " + note);
		}
		
		//第四步：关闭数据库
		rs.close(); //可选
		stmt.close();  //可选
		conn.close();
	}

}