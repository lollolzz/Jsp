<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%


	request.setCharacterEncoding("UTF-8");
	String seq 		= request.getParameter("seq");
	String title 	= request.getParameter("title");
	String content 	= request.getParameter("content");
	
	ArticleDao.getInstance().updateArticle(title, content, seq);
	
	response.sendRedirect("/Jboard1/view.jsp?seq="+seq);



%>