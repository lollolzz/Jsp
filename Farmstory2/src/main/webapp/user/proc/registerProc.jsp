<%@page import="kr.co.Farmstory2.dao.MemberDao"%>
<%@page import="kr.co.Farmstory2.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String uid 		= request.getParameter("uid");
	String pass1 	= request.getParameter("pass1");
	String name 	= request.getParameter("name");
	String nick 	= request.getParameter("nick");
	String email 	= request.getParameter("email");
	String hp		= request.getParameter("hp");
	String zip 		= request.getParameter("zip");
	String addr1	= request.getParameter("addr1");
	String addr2	= request.getParameter("addr2");
	String regip	= request.getRemoteAddr();
	// request.getRemoteAddr() - 클라이언트의(주소) ip주소 가져오기
	
	MemberBean mb = new MemberBean();
	mb.setUid(uid);
	mb.setPass(pass1);
	mb.setName(name);
	mb.setNick(nick);
	mb.setEmail(email);
	mb.setHp(hp);
	mb.setZip(zip);
	mb.setAddr1(addr1);
	mb.setAddr2(addr2);
	mb.setRegip(regip);
	
	MemberDao.getInstance().insertMember(mb);
	
	// 리다이렉트
	response.sendRedirect("/Farmstory2/user/login.jsp");
	




%>