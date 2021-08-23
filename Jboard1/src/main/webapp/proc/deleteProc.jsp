<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String seq = request.getParameter("seq");
	
	
	// 싱글톤 생성하여둔것을 불러오기 
	ArticleDao.getInstance().deleteArticle(seq);
	
	// 리다이렉트 
	response.sendRedirect("/Jboard1/list.jsp?pg=1");




%>