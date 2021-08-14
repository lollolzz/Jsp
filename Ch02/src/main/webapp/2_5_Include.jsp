<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>2_5_Include</title>
	<%-- 
		날짜 : 2021/08/04
		이름 : 권능한
		내용 : JSP Include 지시자 실습하기
	 --%>
</head>
<body>
	<h3>5.Jsp Include 지시자</h3>
	<!-- 
	헤더와 푸터 부분의 내용이 많을 시 다 코딩하지 않고 
	묘듈화 한다
	 -->
	<%@ include file ="./inc/_header.jsp" %>
	
	<main>
		<h1>메인 영역 입니다.</h1>
	</main>
	<%@ include file="./inc/_footer.jsp" %>
</body>
</html>
