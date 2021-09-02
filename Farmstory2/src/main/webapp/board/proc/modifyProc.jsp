<%@page import="kr.co.Farmstory2.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String uri     = request.getParameter("uri");
	String seq     = request.getParameter("seq");
	String title   = request.getParameter("title");
	String content = request.getParameter("content");
	String cate    = request.getParameter("cate");
	String group   = request.getParameter("group");
	
	ArticleDao.getInstance().updateArticle(title, content, seq);
	
	response.sendRedirect("/Farmstory2/board/view.jsp?group="+group+"&cate="+cate+"&seq="+seq);
%>