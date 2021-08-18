<%@page import="java.util.List"%>
<%@page import="Kr.co.jboard1.bean.ArticleBean"%>
<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@page import="Kr.co.jboard1.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		
	MemberBean mb = (MemberBean) session.getAttribute("sessMember");
	
	if(mb == null){
		// 로그인을 하지 않고 list 페이지를 요청했을 때
		response.sendRedirect("/Jboard1/user/login.jsp?success=102");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("seq");
	// 뷰페이지는 목록에 있는 글 누르면 접속되는 페이지 어서 seq로 수신 한다 
	
	ArticleDao dao = ArticleDao.getInstance();
	
	// ArticleDao라는 싱글톤 class를 만들어서 하나로 관리하자
	// 조회수 업데이트
	dao.updateArticleHit(seq);
	
	// 글 가져오기
	ArticleBean article = dao.selectArticle(seq);
	
	// 댓글 가져오기 
	List<ArticleBean> comments = dao.selectComments(seq);

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글보기</title>
    <link rel="stylesheet" href="/Jboard1/css/style.css"/>
</head>
<body>
    <div id="wrapper">
        <section id="board" class="view">
            <h3>글보기</h3>
            <table>
                 <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" value="<%= article.getTitle() %>" readonly/></td>
                </tr>
                <% if(article.getFile() == 1){ %>
                <tr>
                <tr>
                    <td>첨부파일</td>
                    <td>
                        <a href="#"><%= article.getFb().getOriName() %></a>
                        <span><%= article.getFb().getDownload() %>회 다운로드</span>
                    </td>
                </tr>
                 <% } %>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="content" readonly><%= article.getContent() %></textarea>
                    </td>
                </tr>
            </table>
            <div>
                <a href="#" class="btnDelete">삭제</a>
                <a href="/Jboard1/modify.jsp" class="btnModify">수정</a>
                <a href="/Jboard1/list.jsp" class="btnList">목록</a>
            </div>  
            
            <!-- 댓글리스트 -->
            <section class="commentList">
                <h3>댓글목록</h3>
                <% for(ArticleBean comment : comments){ %>
                <article class="comment">
                    <span>
                        <span><%= comment.getNick() %></span>
                        <span><%= comment.getRdate().substring(2, 10) %></span>
                    </span>
                    <textarea name="comment" readonly><%= comment.getContent() %></textarea>
                    <div>
                        <a href="#">삭제</a>
                        <a href="#">수정</a>
                    </div>
                </article>
              <% } %>
              
              <% if(comments.size() == 0) { %>
                <p class="empty">
                    등록된 댓글이 없습니다.
                </p>
                <% } %>
            </section>

            <!-- 댓글입력폼 -->
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="/Jboard1/proc/CommentProc.jsp" method="post">
                	<!-- article.getSeq()는 댓글을 다는 글의 번호를 가져 오는 것이다 이것을 댓글을 단 Seq의 parent에 저장시키는 것 -->
                	<input type="hidden" name="parent" value="<%= article.getSeq() %>" />
                	<!-- uid도 마찬가지로 위의 주석 내용과 동일하게 DB에 내용이 저장 된다 . -->
                	<input type="hidden" name="uid" value="<%= mb.getUid() %>" />
                	
                    <textarea name="content"></textarea>
                    <div>
                        <a href="#" class="btnCancel">취소</a>
                        <input type="submit" class="btnWrite" value="작성완료"/>
                    </div>
                </form>
            </section>

        </section>
    </div>    
</body>
</html>