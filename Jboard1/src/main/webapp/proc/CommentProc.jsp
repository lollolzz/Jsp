<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@page import="Kr.co.jboard1.bean.ArticleBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 댓글 등록과 숫자 세기에 관한 페이지 
	
	request.setCharacterEncoding("utf-8");

	String parent = request.getParameter("parent");
	String content = request.getParameter("content");
	String uid = request.getParameter("uid");
	String regip = request.getRemoteAddr();


	ArticleBean ab = new ArticleBean();
	ab.setParent(parent);
	ab.setContent(content);
	ab.setUid(uid);
	ab.setRegip(regip);

	// 댓글 등록하기
	ArticleDao.getInstance().insertComment(ab);
	
	// 댓글 카운트 업데이트
	ArticleDao.getInstance().updateCommentCount(parent, +1);
	
	// 리다이렉트
	response.sendRedirect("/Jboard1/view.jsp?seq="+parent);
	// 댓글을 달면 새로운 seq가 생성되고 그 뒤 +parent로 댓글을 작성햇던 해당 글이 db에 업로드 된다  s
%>