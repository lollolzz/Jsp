<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 현재 클라이언트 사용자 정보 세션삭제
	session.invalidate();
	// 로그인 페이지 이동
	response.sendRedirect("/Jboard1/user/login.jsp?success=101");
%>
