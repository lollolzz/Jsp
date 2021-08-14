<%@page import="Kr.co.jboard1.db.Sql"%>
<%@page import="Kr.co.jboard1.db.DBConfig"%>
<%@page import="Kr.co.jboard1.db.Sql"%>
<%@page import="Kr.co.jboard1.db.DBConfig"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String uid   = request.getParameter("uid");
	String pass1 = request.getParameter("pass1");
	String name  = request.getParameter("name");
	String nick  = request.getParameter("nick");
	String email = request.getParameter("email");
	String hp    = request.getParameter("hp");
	String zip   = request.getParameter("zip");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String regip = request.getRemoteAddr();
	try{
		// 1,2단계
		Connection conn= DBConfig.getInstance().getConnection();
		// 3단계
		PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_MEMBER);
		psmt.setString(1, uid);
		psmt.setString(2, pass1);
		psmt.setString(3, name);
		psmt.setString(4, nick);
		psmt.setString(5, email);
		psmt.setString(6, hp);
		psmt.setString(7, zip);
		psmt.setString(8, addr1);
		psmt.setString(9, addr2);
		psmt.setString(10, regip);
		
		// 4단계
		psmt.executeUpdate();		
		// 5단계
		
		// 6단계
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	// 리다이렉트
	response.sendRedirect("/Jboard1/user/login.jsp");
%>