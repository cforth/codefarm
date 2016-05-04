<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>  
    <title>登陆程序</title>
    <link rel="stylesheet" type="text/css" href="css/cfxyz.css">
    <script type="text/javascript" src="js/cfxyz.js"></script>
    <script type="text/javascript" src="js/login.js"></script>
  </head>
  <body>
  	<h1>用户登陆</h1>
<%
  	//如果有check.jsp跳转回login.jsp，那么表示用户名或密码错误，属于错误提示信息
  	String err = request.getParameter("err");
  	if("loginError".equals(err)) {
%>
	<h2>登陆失败，错误的用户名或密码！</h2>
<%
	} else if("dataError".equals(err)) {
%>
	<h2>请输入正确的登陆信息！</h2>
<%
	}
%>
    <form action="check.jsp" method="post" onsubmit="return validate()">
    	<table border="1" cellpadding="5" cellspacing="0" width="100%" class="init">
    		<tr onmousemove="changeColor(this,'#FFFFFF')" onmouseout="changeColor(this,'#F2F2F2')">
    			<td width="15%">用户名：</td>
    			<td width="45%"><input type="text" name="mid" id="mid" class="init" onblur="validateMid()"></td>
    			<td width="40%"><span id="midMsg"></span></td>
    		</tr>
    		<tr onmousemove="changeColor(this,'#FFFFFF')" onmouseout="changeColor(this,'#F2F2F2')">
    			<td>密&nbsp;&nbsp;码：</td>
    			<td><input type="password" name="password" id="password" class="init" onblur="validatePassword()"></td>
    			<td><span id="passwordMsg"></span></td>
    		</tr>
    		<tr onmousemove="changeColor(this,'#FFFFFF')" onmouseout="changeColor(this,'#F2F2F2')">
    			<td colspan="3">
    				<input type="submit" value="登陆">
    				<input type="reset" value="重置">
    			</td>
    		</tr>
    	</table>
    </form>
  </body>
</html>
