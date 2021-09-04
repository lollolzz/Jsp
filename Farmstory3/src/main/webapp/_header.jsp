<%@page import="kr.co.Farmstory3.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberBean mb = (MemberBean) session.getAttribute("sessMember");

	String success = request.getParameter("success");
	// 아래의 <script>문에 작성 된것을 받아오는 것
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리</title>
    <link rel="stylesheet" href="Farmstory3/css/style.css?ver=1"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- ajax사용을 위한 링크를 script로 불러오는것 
    	자바스크립트를 이용해 서버와 브라우저가 비동기 방식으로 데이터를 교환할 수 있는 통신 기능 -->
    <script>
    	var = success = "<%= success %>";
    	
    	if(success == 100){
    		alert('일치하는 회원이 없습니다.\n아이디, 비밀번호를 다시 확인해 주세요.');
    	}else if(success == 101){
    		alert('정상적으로 로그아웃이 되었습니다.')
    	}else if(success == 102){
    		alert('먼저 로그인을 하셔야 합니다.')
    	}
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory3/index.jsp" class="logo"><img src="/Farmstory3/img/logo.png" alt="로고"></a>
            <!-- alt는 이미지에대한 설명 글이다. -->
            <p>
                <!-- div를 사용해도 된다 div는 영역의 느낌이다.-->
                <a href="/Farmstory3">HOME |</a>
                <% if(mb == null){ %>
	                <a href="/Farmstory3/user/login.jsp">로그인 |</a>
	                <a href="/Farmstory3/user/terms.jsp">회원가입 |</a>
                <%}else{ %>
                	<a href="/Farmstory3/user/logout.jsp">로그아웃 |</a>
                <%} %>
               		<a href="/Farmstory3/board/list.jsp?group=Communtiry&cate=qna">고객센터 |</a>
            </p>
            <img src="/Farmstory3/img/head_txt_img.png" alt="3만원이상 무료배송, 팜카드 10%적립"/>

            <ul class="gnb">
                <li><a href="/Farmstroy3/introduction/hello.jsp">팜스토리 소개</a></li>
                <li><a href="/Farmstroy3/board/list.jsp?group=Market&cate=market"><img src="/Farmstory3/img/head_menu_badge.png" alt="30%" class="badge">장바구니</a></li>
                <li><a href="/Farmstroy3/board/list.jsp?group=Croptalk&cate=story">농작물이야기</a></li>
                <li><a href="/Farmstory2/board/list.jsp?group=Event&cate=event">이벤트</a></li>
                <li><a href="/Farmstory2/board/list.jsp?group=Community&cate=notice">커뮤니티</a></li>

            </ul>
        </header>