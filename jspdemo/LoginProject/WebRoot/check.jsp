<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%! //定义数据库相关连接信息
    public static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver" ;
    public static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl" ;
    public static final String USER = "scott" ;
    public static final String PASSWORD = "tiger" ;
%>
<% //接收请求参数
	String mid = request.getParameter("mid");
	String password = request.getParameter("password");
	if(mid == null || password == null) {
%>
	<jsp:forward page="login.jsp">
	<jsp:param name="err" value="dataError"/>
	</jsp:forward>
<%
	} else {
		boolean flag = false ; //保存成功与否的标记
%>
<% 		// 编写程序语句
	    Connection conn = null;
	    PreparedStatement pstmt = null ;
	    ResultSet rs = null ;
	    String sql = "SELECT COUNT(mid) FROM member WHERE mid=? AND password=?" ;
	
	    Class.forName(DBDRIVER);
	    conn = DriverManager.getConnection(DBURL,USER,PASSWORD) ;
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1,mid);
	    pstmt.setString(2,password);
	    rs = pstmt.executeQuery();
	    if(rs.next()) {
	    	if(rs.getInt(1) == 1) { //登陆成功
	    		flag = true; //修改标记
	    	}
	    }
	    conn.close(); //数据库验证完毕后关闭连接
%>
<%
		if(flag) { //如果登陆成功，跳转到welcome.jsp
%>
			<jsp:forward page="welcome.jsp" />
<%
		} else { //表示失败
	%>
	 		<jsp:forward page="login.jsp">
	 			<jsp:param name="err" value="loginError"/>
	 		</jsp:forward>
<%
		}
	}
 %>
<html>
  <head>  
    <title>登陆程序</title>
  </head>
  <body>
    This is my JSP page. <br>
  </body>
</html>
