<%@page import="Kr.co.jboard1.bean.ArticleBean"%>
<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@page import="java.util.List"%>
<%@page import="Kr.co.jboard1.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberBean mb = (MemberBean) session.getAttribute("sessMember");
	//sessMember는 세션 고유번호 ,이게 세션 객체에 저장 된다 
	
	if(mb == null){
		// 로그인을 하지 않고 list 페이지를 요청했을 때
		response.sendRedirect("/Jboard1/user/login.jsp?success=102");
		return;
	}
	// 전송데이터 수신
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	
	if(pg == null){
		pg = "1";
	}// pg를 한번에 차리하기 위한 함수식이다 
	
	
	// 페이지 처리
	int start = 0;
	int currentPage = Integer.parseInt(pg);
	// paresInt 레퍼클래스의 메서드,문자열을 숫자로 전환 시킨
	int total = ArticleDao.getInstance().selectCountTotal();
	int lastPageNum = 0;
	// getInstance()는 new 연산자를 이용해서 클래스를 새로운 메모리에 할당 그리고 싱글톤 사용시 사용한다 
	// 최초에 할당된 하나의 메모리를 계속 쓰는 방식 ---- 즉 싱글톤에 사용한다는 소리 
	
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = total / 10 + 1;
	}
	start = (currentPage - 1) * 10;
	
	int pageStartNum = total - start;
	int groupCurrent = (int)Math.ceil(currentPage / 10.0);
	// 실수로 나누는 이유는 나머지를 가지기 위해서이다. 실수이기 때문에 (int)화 해주고 Math.ceil를 사용해서 반올림 하여준다. 	
	int groupStart = (groupCurrent - 1) * 10 + 1;
	int groupEnd = groupCurrent * 10;
	
	if(groupEnd > lastPageNum){
		groupEnd = lastPageNum;
	}
	
	List<ArticleBean> articles = ArticleDao.getInstance().selectArticles(start);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글목록</title>
    <link rel="stylesheet" href="/Jboard1/css/style.css">    
</head>
<body>
    <div id="wrapper">
        <section id="board" class="list">
            <h3>글목록</h3>
            <article>
                <p>
                    <%= mb.getNick() %>님 반갑습니다.
                    <a href="/Jboard1/user/proc/logoutProc.jsp" class="logout">[로그아웃]</a>
                </p>
                <table border="0">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>날짜</th>
                        <th>조회</th>
                    </tr>
                    <% for(ArticleBean article : articles){ %>
                    <tr>
                        <td><%= pageStartNum-- %></td>
                        <td><a href="/Jboard1/view.jsp?seq=<%= article.getSeq() %>"><%= article.getTitle() %></a>&nbsp;[<%= article.getComment() %>]</td>
                        <td><%= article.getNick() %></td>
                        <td><%= article.getRdate().substring(2 ,10) %></td>
                        <!-- substring으로 잘라낸 이유는 게시글 업로드의 년월일까지만 보기 위해서 이다. -->
                        <td><%= article.getHit() %></td>
                    </tr>
                    <% } %>
                </table>
            </article>

            <!-- 페이지 네비게이션 -->
            <div class="paging">
            	<% if(groupStart > 1) { %>
                	<a href="/Jboard1/list.jsp?pg<%= groupStart -1 %>" class="prev">이전</a>
                <% } %>
                
                <% for(int i=groupStart ; i<=groupEnd; i++){ %>
                	<a href="/Jboard1/list.jsp?pg=<%= i %>" class="num <%=(currentPage == i) ? "current":"" %>"><%= i %></a>                
                <% } %>
                
                <% if(groupEnd < lastPageNum){ %>
                	<a href="/Jboard1/list.jsp?pg=<%=groupEnd + 1 %>" class="num">다음</a>                
				<% } %>
            </div>

            <!-- 글쓰기 버튼 -->
            <a href="/Jboard1/write.jsp?pg<%= pg %>" class="btnWrite">글쓰기</a>

        </section>
    </div>    
</body>
</html>