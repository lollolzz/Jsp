<%@page import="Kr.co.Farmstory1.dao.ArticleDao"%>
<%@page import="Kr.co.Farmstory1.bean.ArticleBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
		request.setCharacterEncoding("utf-8");
		String cate		= request.getParameter("cate");
		String title 	= request.getParameter("title");
		String content 	= request.getParameter("content");
		String uid 		= request.getParameter("uid");
		String uri 		= request.getParameter("uri");
		String regip 	= request.getRemoteAddr();

		ArticleBean article = new ArticleBean();
		article.setCate(cate);
		article.setTitle(title);
		article.setContent(content);
		article.setFile(0);
		article.setUid(uid);
		article.setRegip(regip);
	
		ArticleDao.getInstance().insertArticle(article);
		
		response.sendRedirect(uri);
		// 글쓰기를 눌럿던 페이지의 uri주소를 불러온다 


%>