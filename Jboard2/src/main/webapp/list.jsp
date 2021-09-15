<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글목록</title>
    <link rel="stylesheet" href="./css/style.css">    
</head>
<body>
    <div id="wrapper">
        <section id="board" class="list">
            <h3>글목록</h3>
            <article>
                <p>
                    ${sessMember.nick}님 반갑습니다.
                    <a href="/Jboard2/user/logout.do" class="logout">[로그아웃]</a>
                </p>
                <table border="0">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>날짜</th>
                        <th>조회</th>
                    </tr>
					<!--  db에 저장되어져 있는 내용을 불러와야 하기 때문에 표현식을 사용해 주었다
					ListService에서 req.setAttribute("articles", articles);해준것으로 내용을 불러온다. -->                    
                    
                  	<c:forEach var="vo" items="${articles}">
	                    <tr>
	                        <td>${pageStartNum = pageStartNum-1}</td>
	                        <td><a href="/Jboard2/view.do">${vo.title}</a>&nbsp;[${vo.comment}]</td>
	                        <!-- &nbsp;는 웹페이제이서 공백을 표시하기 위해 사용되는 특수 문자 
	                        html에서는 여러개의 공백이 있어도 하나의 공백으로만 인정합니다. 따라서 여러칸을 띄워 주고 &nbsp;
	                        와 같은 특수문자의 도움을 받아야한다. -->
	                        <td>${vo.nick}</td>
	                        <td>${vo.rdate}</td>
	                        <td>${vo.hit}</td>
	                    </tr>
                    </c:forEach>
                </table>
            </article>

            <!-- 페이지 네비게이션 
            페이지 단위를 10페이지씩 묶어서 다음 혹은 이전으로 눌렀을 경우 예) 1~10 {groups[]으로 표현}에서 다음 
           을 누를 경우 11~20페이지로 이동하는것을 구현 -->
           <div class="paging">
            	
            	<c:if test="${groups[0] > 1}">
                	<a href="/Jboard2/list.do?pg=${groups[0] - 1}" class="prev">이전</a>
                </c:if>
                
                <c:forEach var="i" begin="${groups[0]}" end="${groups[1]}">
                <!-- 현재페이지 내의 그룹을 나타내야 하기 때문에 begin="${groups[0]}" end="${groups[1]} 이런 식으로 표현
                0~1그룹사이의 페이지중 하나가 현재 페이지라는 의미 0,1등의 숫자는 그룹을 다음으로 이동시킬 수록 1,2 이런 식으로 바뀜 -->
                	<a href="/Jboard2/list.do?pg=${i}" class="${currentPage == i ? 'current':'off'}">${i}</a>
                </c:forEach>
                
                <c:if test="${groups[1] < lastPageNum}">                
                	<a href="/Jboard2/list.do?pg=${groups[1] + 1}" class="next">다음</a>
                </c:if>
            </div>

            <!-- 글쓰기 버튼 -->
            <a href="/Jboard2/write.do" class="btnWrite">글쓰기</a>

        </section>
    </div>    
</body>
</html>