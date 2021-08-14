<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3_4_Session</title>
	<%--
	 	날 짜 : 2021/08/05
	 	이 름 : 권능한 
	 	내 용 : JSP Session 내장객체 실습하기
	 	
	 	session 내장객
	 	- 최초요청에서 부터 마지막 요청까지의 전체 시간
	 	- 클라이언트에서 서버로 요청할 때 서버에 기록되는 클라이언트(Session table)
	 	- 서버는 각 클라이언트에 대한 고유번호(Session ID)를 부여  
	 --%>
</head>
<body>
	<h4>4.Session 실습하기 </h4>
	<form action="./proc/sessionProc.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uid"/></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pass"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="로그인"/>
				</td>
			</tr>				
		</table>
	</form>


</body>
</html>
</html>