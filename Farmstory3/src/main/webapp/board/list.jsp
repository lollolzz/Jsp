<%@page import="kr.co.Farmstory3.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.Farmstory3.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송데이터 수신
	request.setCharacterEncoding("utf-8");
	String pg 		= request.getParameter("pg");
	String group 	= request.getParameter("group");
	// aside에서 보내는 cate를 group으로 묶은것
	String cate 	= request.getParameter("cate");
	String includeFile 	= "./_aside" + group + ".jsp";
	
	if(pg == null){
		pg = "1";
	}
	// 페이지 계산 처리
	// 페이지 계산 처리 
	int start = 0;
	int currentPage = Integer.parseInt(pg);
	int total = ArticleDao.getInstance().selectCountTotal(cate);
	int lastPageNum = 0;
	
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = total / 10 + 1;
	}	
	start = (currentPage - 1) * 10;
	
	int pageStartNum = total - start;
	int groupCurrent = (int)Math.ceil(currentPage / 10.0);
	int groupStart = (groupCurrent - 1) * 10 + 1;
	int groupEnd = groupCurrent * 10;
	
	if(groupEnd > lastPageNum){
		groupEnd = lastPageNum;
	}

	// 게시물 가져오기
	List<ArticleBean> article = ArticleDao.getInstance().selectArticles(cate, start);

%>
<%@ include file="../_header.jsp" %>
<jsp:include page="<%= includeFile %>">
	<jsp:param name="cate" value="<%= cate %>"/>
</jsp:include>
<!-- _aside페이지를 group.jsp로 묶어서 각페이지 마다 include시킬 예정 -->