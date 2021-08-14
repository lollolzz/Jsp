<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

 /*
 		날 짜 : 2021/08/09
		이 름 : 권능한
		내 용 : Jsp JSON 데이터 실습하기
		
		Json 데이터
		- JavaScript Object Notation(자바스크립트 객체 표기법)
		<java에서는 class로 객체를 표현 한다>
		- 이기종간의 데이터 교환할 때 사용하는 표준 포맷 

 
 */
 
 	String jsonData = "{\"uid\":\"A101\", \"name\":\"홍길\", \"hp\":\"010-1234-1111\", \"age\":25}";
 	out.print(jsonData);
 
 %>