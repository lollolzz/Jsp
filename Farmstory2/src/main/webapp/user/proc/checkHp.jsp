<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.Farmstory2.dao.MemberDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송데이터 수신
	request.setCharacterEncoding("utf-8");
	String hp = request.getParameter("hp");
	
	// 1:uid 체크, 2:nick 체크, 3:email 체크, 4:hp 체크
	// js폴더에 있는 ajax부분에 있는것과 연동되어 있다.
	int result = MemberDao.getInstance().selectCountUserInfo(4,hp);
	
	// Json출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	out.print(json);

%>