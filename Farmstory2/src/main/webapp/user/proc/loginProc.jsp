<%@page import="kr.co.Farmstory2.dao.MemberDao"%>
<%@page import="kr.co.Farmstory2.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
	request.setCharacterEncoding("utf-8");
	String uid  = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	MemberBean mb = MemberDao.getInstance().selectMember(uid, pass);
	
	if(mb != null){
		// 회원이 맞을 경우
		session.setAttribute("sessMember", mb);
		// session이란 웹 사이트의 여러 페이지에 걸쳐 사용되는 정보를 저장하는 방법을 의미
		// 사용자가 브라우저를 닫아 서버와의 연결을 끝내는 시점까지를 세션이라고 합니다.
		// 세션은 서비스가 돌아가는 서버측에 데이터를 저장, 세션의 키값만을 클라이언트 측에 남겨둠
		// 브라우저는 필요할때마다 이 키값을 이용하여 서버에 저장된 데이터를 사용
		// 이러한 세션은 보안에 취약한 쿠키를 보완해주는 역할을 한다
		
		//setAttribute(이름, 값) 세션이 유지되는 동안 저장
		response.sendRedirect("/Farmstory2");	
		
	}else{
		// 회원이 아닐 경우
		response.sendRedirect("/Farmstory2/user/login.jsp?success=100");
	}
%>