<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글보기</title>
    <link rel="stylesheet" href="./css/style.css"/>
</head>
<body>
    <div id="wrapper">
        <section id="board" class="view">
            <h3>글보기</h3>
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" value="${vo.title}" readonly/></td>
                </tr>
                <c:if test="${vo.file == 1}">
                <tr>
                    <td>첨부파일</td>
                    <td>
                        <a href="/Jboard3/fileDownload.do?fseq=${vo.fb.fseq}">${vo.fb.oriName}</a>
                        <!--  서비스 페이지에서 parameter로 받아준다 
                        vo의 fb에서 원레이름으로 첨부파일을 불러온다-->
                        <span>${vo.fb.download}회 다운로드</span>
                    </td>
                </tr>
                </c:if>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="content" readonly>${vo.content}</textarea>
                    </td>
                </tr>
            </table>
            <div>
                <a href="/Jboard3/delete.do" class="btnDelete">삭제</a>
                <a href="/Jobard3/modify.do" class="btnModify">수정</a>
                <a href="/Jboard3/list.do" class="btnList">목록</a>
            </div>
            
            <!-- 댓글리스트 -->
            <section class="commentList">
                <h3>댓글목록</h3>
                
                <c:forEach var="comment" items="${comments}">
	                <article class="comment">
	                    <span>
	                        <span>${comment.nick}</span>
	                        <span>${comment.rdate}</span>
	                    </span>
	                    <textarea name="comment" readonly>${comment.content}</textarea>
	                    <div>
	                        <a href="#">삭제</a>
	                        <a href="#">수정</a>
	                    </div>
	                </article>
                </c:forEach>
                
                <c:if test="${comments.size() == 0}">
	                <p class="empty">
	                    등록된 댓글이 없습니다.
	                </p>
                </c:if>
            </section>

            <!-- 댓글입력폼 -->
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="/Jboard3/comment.do" method="post">
                	<input type="hidden" name="parent" value="${vo.seq}"/>
                	<!--  글번호 불러오기  -->
                	<input type="hidden" name="uid" value="${sessMember.uid}"/>
                	<!-- 댓글 작성자 uid 가져오기 -->
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