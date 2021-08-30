

<%@page import="java.util.List"%>
<%@page import="Kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="Kr.co.Farmstory1.dao.ArticleDao"%>
<%@page import="Kr.co.Farmstory1.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uri = request.getRequestURI();

	
	// 뷰페이지는 목록에 있는 글 누르면 접속되는 페이지여서 seq로 수신한다.
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String seq = request.getParameter("seq");
	
	// 싱글톤 사용
	ArticleDao dao = ArticleDao.getInstance();
	
	// 글 가져오기
	ArticleBean article = dao.selectArticle(seq);
	
	// 조회수 업데이트
	dao.updateArticleHit(seq);
	
	// 댓글 가져오기
	List<ArticleBean> comments = dao.selectComments(seq);
%>

<section id="board" class="view">
    <h3>글보기</h3>
    <table>
        <tr>
            <td>제목</td>
            <td><input type="text" name="title" value="<%= article.getTitle() %>" readonly/></td>
        </tr>
        <% if(article.getFile() == 1){ %>
        <tr>
            <td>첨부파일</td>
            <td>
                <a href="/Farmstory1/board/proc/download.jsp?fseq=<%=article.getFb().getFseq() %>"><%= article.getFb().getOriName() %></a>
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
    	<% if(uid.equals(article.getUid())){ %>
        	<a href="/Farmstory1/board/proc/deleteProc.jsp?seq=<%= article.getSeq() %>&uri=<%= uri %>" class="btnDelete">삭제</a>
       		<a href="<%= uri %>?mode=m&seq=<%= article.getSeq() %>" class="btnModify">수정</a>
     	<% } %>
        <a href="<%= uri %>" class="btnList">목록</a>
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
             <textarea name="comment" readonly data-seq="<%= comment.getSeq() %>"><%= comment.getContent() %></textarea>
             
             <% if(uid.equals(comment.getUid())){ %>
             <div>
                 <a href="/Farmstory1/board/proc/deleteCommentProc.jsp?parent=<%= comment.getParent() %>&seq=<%= comment.getSeq() %>&uri=<%= uri %>" class="btnCommentDel">삭제</a>
                 <a href="#" class="btnCommentModify">수정</a>
                 <a href="#" class="btnCommentCancel">취소</a>
             </div>
             <% } %>
         </article>
        <% } %>
        
        <% if(comments.size() == 0){ %>
        	<p class="empty">등록된 댓글이 없습니다.</p>
        <% } %>
    </section>

    <!-- 댓글입력폼 -->
    <section class="commentForm">
        <h3>댓글쓰기</h3>
        <form action="/Farmstory1/board/proc/insertCommentProc.jsp" method="post">
        	<input type="hidden" name="parent" value="<%= article.getSeq() %>" />
        	<input type="hidden" name="uid" value="<%= uid %>" />
        	<input type="hidden" name="uri" value="<%= uri %>" />
        
            <textarea name="content"></textarea>
            <div>
                <a href="#" class="btnCancel">취소</a>
                <input type="submit" class="btnWrite" value="작성완료"/>
            </div>
        </form>
    </section>
</section>