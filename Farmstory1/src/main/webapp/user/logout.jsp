<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	session.invalidate();	
	//세션을 완전삭제하기 -- 로그아웃하면 로그인 정보세션을 삭제하면 되기 때문이다 
	response.sendRedirect("Farmstory1");





%>