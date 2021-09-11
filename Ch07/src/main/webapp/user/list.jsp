  
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>list</title>
</head>
<body>
	<h3>User 목록</h3>
	
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>나이</th>
			<th>관리</th>
		</tr>
		<c:forEach var="user" items="${requestScope.users}">
			<tr><!-- users안에 user들이 들어있다고 생각하면 된다. -->
				<td>${user.getUid()}</td>
				<td>${user.name}</td>
				<td>${user.hp}</td>
				<td>${user.age}</td>
				<td>
					<a href="/Ch07/user/modify.do?uid=${user.uid}">수정</a>
					<!-- uid로 하는이유는 그냥 제일 위에 드러나서이다 별이유 없다 
					,,, get방식으로 받아온것
					 -->
					<a href="/Ch07/user/delete.do?uid=${user.uid}">삭제</a>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>