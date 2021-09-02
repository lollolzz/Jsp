<%@page import="kr.co.Farmstory2.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("seq");
	String cate    = request.getParameter("cate");
	String group   = request.getParameter("group");

	
	ArticleDao.getInstance().deleteArticle(seq);
	
	 response.sendRedirect("/Farmstory2/board/list.jsp?group="+group+"&cate="+cate);


%>