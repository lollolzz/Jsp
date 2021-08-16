<%@page import="Kr.co.jboard1.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 프로젝트 시작처리 페이지 
	MemberBean mb = (MemberBean) session.getAttribute("sessMember");

	if(mb == null){
		//로그인을 안했으면 로그인 페이지로 포워드 
		pageContext.forward("./user/login.jsp");
	}else{
		//로그인을 했으며 리스트 페이지로 포워드
		pageContext.forward("./list.jsp");
	}
	
	// forward는 pageConext와 함게 쓰이는 문법
	// forward는 절대 경로 사용 불가능 -> 상대 경로 사용해야함 : ./
	
	
	
%>