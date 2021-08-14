
<%@page import="bean.CustomerBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
 	// DB 정보
 	String host = "jdbc:mysql://54.180.160.240:3306/lollolzz1018";
	String user = "lollolzz1018";       
	String pass = "1234";
	
	List<CustomerBean> customers = new ArrayList<>();
 	
 	try{
 		// 1단계 - JDBC드라이버 로드
 		Class.forName("com.mysql.jdbc.Driver");
 		// 2단계 - 데이터베이스 접속
 		Connection conn = DriverManager.getConnection(host,user,pass);
 		// 3단계 - SQL 실행객체 생성 
 		Statement stmt = conn.createStatement();
 		// 4단계 - SQL 실행
 		String sql = "SELECT * FROM `Customer`;";
 		ResultSet rs = stmt.executeQuery(sql);
 		
 		// 5단계 - 결과셋 처리 (select일 경우)
 		while(rs.next()) {
 			CustomerBean cb = new CustomerBean();
 			cb.setCustid(rs.getInt(1));
 			cb.setName(rs.getString(2));
 			cb.setAddress(rs.getString(3));
 			cb.setPhone(rs.getString(4));
 			
 			customers.add(cb);
 		}
 		// 6단계 - 데이터베이스 종료 
 		rs.close();
 		stmt.close();
 		conn.close();
 		
 		
 	}catch (Exception e) {
 		e.printStackTrace();
 	}
 	%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>list</title>
</head>
<body>
	<h3>고객목록</h3>
	<a href="./register.jsp">고객등록</a>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>주소</th>
			<th>휴대폰</th>
			<th>기타</th>
		</tr>
		<%
			for(CustomerBean customer : customers){
		%>	
		<tr>
			<td><%= customer.getCustid() %></td>
			<td><%= customer.getName() %></td>
			<td><%= customer.getAddress() %></td>
			<td><%= customer.getPhone() %></td>
			<td>
				<a href="./modify.jsp?custid=<%= customer.getCustid() %>">수정</a>
				<a href="./proc/deleteProc.jsp?custid=<%= customer.getCustid() %>">삭제</a>
			</td>
		</tr>	
	<%
		}
	%>
	</table>
</body>
</html>
	