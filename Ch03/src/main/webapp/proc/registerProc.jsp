<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>registerProc</title>
</head>
<body>
	<h3>회원가입 데이터 수신하기</h3>
	<%
		request.setCharacterEncoding("UTF-8");
	
	 	// 데이터 수신
	 	String name = request.getParameter("name");
	 	String gender = request.getParameter("gender");
	 	String [] hobbies = request.getParameterValues("hobby");
	 	String addr = request.getParameter("addr");

	%>
	<p>
		이름 : <%= name %><br/>
		성별 : <%= (gender.equals("1")) ? "남자" : "여자" %><br/> 
		취미 :
		<%
			for(String hobby : hobbies){
				out.print(hobby+",");
			}
		%>
		<br/>
		주소 : <%= addr %><br/>
		
	</p>
	<a href="/Ch03/3_1_Request.jsp">뒤로가기</a>	
		

</body>
</html>
