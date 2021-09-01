<%@page import="com.google.gson.JsonObject"%>
<%@page import="Kr.co.Farmstory1.dao.MemberDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 전송데이터 수신
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	
	// 1:uid 체크 , 2:nick 체크, 3:email 체크 , 4:hp 체크
	int result = MemberDao.getInstance().selectCountUserInfo(3, email);
	
	// Json출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	out.print(json);
	

%>