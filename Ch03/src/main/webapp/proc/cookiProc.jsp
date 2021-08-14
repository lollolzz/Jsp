<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cookiProc</title>
</head>
<body>
	<h3>쿠키 생성 및 쿠키 전송</h3>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// 쿠키 생성 - 쿠키는 내장객체가 아니다 고로 생성해야한다.
		Cookie c1 = new Cookie("uid",id);
		Cookie c2 = new Cookie("pass",pw);
		
		// 쿠키 전송
		response.addCookie(c1);
		response.addCookie(c2);
		
	
	%>
	<h4>클라이언트로 쿠키 전송 완료</h4>
	<a href="./cookieConfirm.jsp">클라이언트에서 서버로 쿠키 전송하기</a>
</body>
</html>
