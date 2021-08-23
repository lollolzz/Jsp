<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");

	String parent = request.getParameter("parent");
	String seq	  = request.getParameter("seq");
	
	// 싱글톤 가져오기
	ArticleDao dao = ArticleDao.getInstance();
	
	// 댓글 삭제 
	dao.deleteComment(seq);
	
	// 댓글 카운트 -1
	dao.updateCommentCount(parent, -1);
	
	// 리다이렉트
	response.sendRedirect("/Jboard1/view.jsp?seq="+parent);
	





%>