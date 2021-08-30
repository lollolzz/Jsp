<%@page import="Kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="Kr.co.Farmstory1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uri = request.getRequestURI();
	// 도메인이후 하부 주소를 가져 온다 .
	
	int begin = uri.lastIndexOf("/")+1;
	int end = uri.lastIndexOf(".");
	
	String cate = uri.substring(begin, end);
	
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	
	if(pg == null){
		pg = "1";
	}
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
	List<ArticleBean> articles = ArticleDao.getInstance().selectArticles(cate,start);
	
%>
<section id="board" class="list">
    <h3>글목록</h3>
    <article>                
        <table border="0">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회</th>
            </tr>
            <%for(ArticleBean article : articles){ %>
            <tr>
               <td><%= pageStartNum-- %></td>
                <td><a href="<%= uri %>?mode=v&seq=<%= article.getSeq() %>"><%= article.getTitle() %></a>&nbsp;[<%= article.getComment() %>]</td>
                <td><%= article.getNick() %></td>
                <td><%= article.getRdate().substring(2, 10) %></td>
                <td><%= article.getHit() %></td>
            </tr>
            <%} %>
        </table>
    </article>

     <!-- 페이지 네비게이션 -->
    <div class="paging">
        
        <% if(groupStart > 1){ %>
        	<a href="<%= uri %>?pg=<%= groupStart - 1 %>" class="prev">이전</a>
        <% } %>
        
        <% for(int i=groupStart ; i<=groupEnd ; i++){ %>
        	<a href="<%= uri %>?pg=<%= i %>" class="num <%= (currentPage == i) ? "current":"" %>"><%= i %></a>
        <% } %>
        
        <% if(groupEnd < lastPageNum){ %>
        	<a href="<%= uri %>?pg=<%= groupEnd + 1 %>" class="next">다음</a>
        <% } %>
    </div>
    
    <!-- 글쓰기 버튼 -->
    <a href="<%= uri %>?mode=w" class="btnWrite">글쓰기</a>
</section>	