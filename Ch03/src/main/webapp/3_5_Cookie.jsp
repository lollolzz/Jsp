<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3_5_Cookie</title>
	<%--
		날 짜 : 2021/08/05
		이 름 : 권능한
		내 용 : JSP Cookie 실습하기
		
		Cookie
		- 클라이언트와 서버간의 식별을 위해 사용되는 조각파일 
		- 쿠키는 서버에서 생성하고 클라이언트에 저장
		- 클라이언트는 전송된 쿠키를 보관하고, 해당 서버로 다시 요청 할 때 보관된 쿠키를 같이 전송
	 --%>
</head>
<body>
	<h3>5. Cookie실습하기</h3>
	
	<form action="./proc/cookiProc.jsp" method = "post">
		<table border ="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id"/></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name ="pw"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type ="submit" value="로그인"/>
				</td>
			</tr>		
		</table>
	</form>
</body>
</html>
