<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String custid  = request.getParameter("custid");
	String name    = request.getParameter("name");
	String address = request.getParameter("address");
	String phone   = request.getParameter("phone");

	// DB 정보
	String host = "jdbc:mysql://54.180.160.240:3306/lollolzz1018";
	String user = "lollolzz1018";       
	String pass = "1234";
	
	try{
		// 1단계 - JDBC 드라이버 로드
		Class.forName("com.mysql.jdbc.Driver");
		
		// 2단계	- 데이터베이스 접속
		Connection conn = DriverManager.getConnection(host, user, pass);
				
		// 3단계	- SQL 실행객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계
		String sql = "UPDATE `Customer` SET ";
			   sql += "`name`='"+name+"',";
			   sql += "`address`='"+address+"',";
			   sql += "`phone`='"+phone+"' ";
			   sql += "WHERE `custid`='"+custid+"';";
		
		stmt.executeUpdate(sql);			   
			   
		// 5단계
		// 6단계
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

	// 리다이렉트
	response.sendRedirect("../list.jsp");

%>
