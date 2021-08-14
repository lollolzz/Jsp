<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3_1_Request</title>
	<!-- 
		날짜 : 2021/08/04
		이름 : 권능한
		내용 : JSP request 내장객체 실습하기 
		
		request 내장객체 
		- 클라이언트의 요청 정보를 갖는 객체 
		- 클라이언트의 전송 데이터(Parameter)를 수신 기능을 제공 
		
		Get전송방식(달라고 요청하는 것)(클라이언트가 서버에게 요청 -> 서버가 클라이언트에 html을 준다)
		- 기본 데이터 전송방식 
		- 서버에 페이지나 데이터를 요청하는 전송방식 
		- 데이터 주소에 노출
		
		Post 전송방식 (클라이언트가 서버에게 해달라고 하는 것 - 시키는 것)
		- 서버에 데이터를 전달하면서 처리를 요청하는 전송방식 
		- 전송 데이터를 요청메세지 삽입해서 전송
	 -->
</head>
<body>
 	<h3>1.JSP request 객체</h3>
 	<h4>로그인</h4>
 	<form action="./proc/loginProc.jsp" method="post">
 		<table border = "1">
 			<tr>
 				<td>아이디</td>
 				<td><input type="txet" name="uid"/></td>
 			</tr>
 			<tr>
 				<td>비밀번호</td>
 				<td><input type="txet" name="pass"/></td>
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