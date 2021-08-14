<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>5_4_Ajax</title>
	<%-- 	
		날 짜 : 2021/08/09
		이 름 : 권능한
		내 용 : AJAX 실습하기
		
		AJAX(Asynchronous javascript And xml)
		- 일반적인 페이지요청을 위한 HTTP 통신과 다르게 데이터 요청을 위한 부분적인 통신 (비동기)(안의 내용만 바뀐다)
		- 부분전환이라고도 하며 최근에 많이 사용 하는 방식
		- 데이터 결과는 일반적으로 Json을 사용
		- 동기식 : 페이지가 순차적으로 넘어가는 방식(화면 렌더링 방식 // 화면 전환) 
	 --%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			// 데이터 출력 태그객체 선택 
			var tds = $('tr>td:nth-child(2)'); // tr의 자식 td의 두 번째 td라는 것을 나타냄 
			
			// 버튼 이벤트 구현 
			$('button').click(function(){//function은 핸들러라고도 한다
				
				// Ajax통싱(데이터 요청)
				$.ajax({
					url :'./5_1_Json.jsp',
					type: 'get',
					dataType: 'json',         //  -> data에 url의 자료가 들어온다 
					success: function(data){ // text함수는 <td>-</td> ,<td></td> 사이의 - 내용을 입력해주는 함수다
						tds.eq(0).text(data.uid);
						tds.eq(1).text(data.name);
						tds.eq(2).text(data.hp);
						tds.eq(3).text(data.age);
						
					}
				});
			});
		});
	
	</script>
	
	
	
</head>
<body>
	<h3>4.Ajax 통신 실습하기</h3>
	<button>데이터 가져오기</button>
	
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>-</td>
		</tr>	
		<tr>
			<td>이름</td>
			<td>-</td>
		</tr>	
		<tr>
			<td>휴대폰</td>
			<td>-</td>
		</tr>	
		<tr>
			<td>나이</td>
			<td>-</td>
		</tr>	
	</table>

</body>
</html>
