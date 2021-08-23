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
    <%-- 	
		날 짜 : 2021/08/09
		이 름 : 권능한
		내 용 : AJAX 실습하기
		
		AJAX(Asynchronous javascript And xml)
		- 일반적인 페이지요청을 위한 HTTP 통신과 다르게 데이터 요청을 위한 부분적인 통신 (비동기)(안의 내용만 바뀐다)
		- 부분전환이라고도 하며 최근에 많이 사용 하는 방식
		- 데이터 결과는 일반적으로 Json을 사용
		- 동기식 : 페이지가 순차적으로 넘어가는 방식(화면 렌더링 방식 // 화면 전환) 
	 --%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
    	$(document).ready(function(){
    		
    		// 댓글 삭제
    		$('.btnCommentDel').click(function(){
    			var result = confirm('정말 삭제 하시겠습니까?');
    			return result;
    		});
    		
    		
    		var content = '';
    		
    		// 댓글 수정
    		$('.btnCommentModify').click(function(){
    			
    			var tag = $(this);
    			var mode = $(this).text();    			    			
    			var textarea = $(this).parent().prev();
    			
    			if(mode == '수정'){
    				// 수정모드
    				content = textarea.val(); 
    				
    				$(this).prev().css('display', 'none');
    				$(this).next().css('display', 'inline');
    				$(this).text('수정완료');
    				textarea.attr('readonly', false).focus();
        			textarea.css({
        				'background': 'white',
        				'outline': '1px solid gray'
        			});
        			
    			}else{
    				// 수정완료 모드
    				
    				var seq     = textarea.attr('data-seq');
    				var comment = textarea.val(); 
    				
    				var jsonData = {
    						'seq': seq,
    						'comment': comment
    					};
    				
    				$.ajax({
    					url: '/Jboard1/proc/updateComment.jsp',
    					type: 'post',
    					data: jsonData,   // 서버로 전송하는 데이터(JSON) 지정
    					dataType: 'json', // 서버로 부터 전달되는 데이터 종류
    					success: function(data){
    						if(data.result == 1){
    							alert('댓글 수정이 성공 했습니다.');
    							
    							// 수정모드 해제
    							tag.text('수정');
    							tag.prev().css('display', 'inline');
    							tag.next().css('display', 'none');    			    			    							
    			    			textarea.attr('readonly', true);
    			    			textarea.css({
    			    				'background': 'transparent',
    			    				'outline': 'none'
    			    			});
    			    			
    						}else{
    							alert('댓글 수정이 실패 했습니다.');
    						}
    					}
    				});
    			}
    			return false;
    		});
    		
    		// 댓글 수정 취소
    		$('.btnCommentCancel').click(function(e){
    			e.preventDefault();
    			$(this).prev().text('수정');
    			$(this).prev().prev().css('display', 'inline');
    			$(this).css('display', 'none');
    			
    			var textarea = $(this).parent().prev();
    			
    			textarea.val(content);
    			textarea.attr('readonly', true);
    			textarea.css({
    				'background': 'transparent',
    				'outline': 'none'
    			});	
    		});
    		
    		
    	});
    
    </script>
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
            	<% if(mb.getUid().equals(article.getUid())) { %>
	                <a href="/Jboard1/proc/deleteProc.jsp?seq=<%= article.getSeq() %>" class="btnDelete">삭제</a>
	                <!-- 이 곳의 seq는 댓글을 쓴 parent의 설정된 seq값이다  -->
	                <a href="/Jboard1/modify.jsp?seq=<%= article.getSeq() %>" class="btnModify">수정</a>
	                
                <% } %>
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
                     <textarea name="comment" readonly data-seq="<%= comment.getSeq() %>"><%= comment.getContent() %></textarea>
                    
                    <% if(mb.getUid().equals(comment.getUid())) { %>
                    <div>
                        <a href="/Jboard1/proc/deleteComment.jsp?parent=<%= comment.getParent() %>&seq=<%= comment.getSeq() %>" class="btnCommentDel">삭제</a>
                        <a href="#" class="btnCommentModify">수정</a>
                        <a href="#" class="btnCommentCancel">취소</a>
                    </div>
                    <% } %>
                    
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