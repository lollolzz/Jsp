<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>4_1_Insert</title>
	<%--
		날 짜 :2021/08/05
		이 름 : 권능한
		내 용 : JDBC프로그래밍 실습하기
	
	 --%>
</head>
<body>
	<h3>1.Jsp Insert실습하기</h3>
	<h4>User 등록</h4>
	
	<form action="./proc/insertProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>아이디<td>
				<td><input type="txet" name="uid"/></td>
			</tr>
			<tr>
				<td>이름<td>
				<td><input type="txet" name="name"/></td>
			</tr>
			
			<tr>
					<td>휴대폰<td>
					<td><input type="txet" name="hp"/></td>
				</tr>
			<tr>
					<td>나이<td>
					<td><input type="txet" name="age"/></td>
				</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="등록하기"/>
				</td>
			</tr>		
		</table>
	</form>
</body>
</html>
