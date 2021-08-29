<%@page import="Kr.co.Farmstory1.bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	MemberBean mb = (MemberBean) session.getAttribute("sessMember");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리</title>
    <link rel="stylesheet" href="/Farmstory1/css/style.css?ver=1">
    <!-- 이클립스에서 css파일 수정 후적용이 안될경우 ?ver=1 을 경로 뒤에 넣어주자 이때 숫자는 상관없다  -->
    <style>
    </style>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory1/index.jsp" class="logo"><img src="/Farmstory1/img/logo.png" alt="로고"></a>
            <!-- alt는 이미지에대한 설명 글이다. -->
            <p>
                <!-- div를 사용해도 된다 div는 영역의 느낌이다.-->
                	<a href="/Farmstory1/index.jsp">HOME |</a>
                <% if(mb == null) { %>
	                <a href="/Farmstory1/user/login.jsp">로그인 |</a>
	                <a href="/Farmstory1/user/terms.jsp">회원가입 |</a>
                
                <% }else{ %>
               		<a href="/Farmstory1/user/logout.jsp">로그아웃 |</a>
                <% } %>
                	<a href="/Farmstory1/community/qna.jsp">고객센터 |</a>
            </p>
            <img src="/Farmstory1/img/head_txt_img.png" alt="3만원이상 무료배송, 팜카드 10%적립"/>

            <ul class="gnb">
                <li><a href="/Farmstory1/introduction/hello.jsp">팜스토리 소개</a></li>
                <li><a href="/Farmstory1/market/market.jsp"><img src="/Farmstory1/img/head_menu_badge.png" alt="30%" class="badge">장바구니</a></li>
                <li><a href="/Farmstory1/croptalk/stroy.jsp">농작물이야기</a></li>
                <li><a href="/Farmstory1/Event/event.jsp">이벤트</a></li>
                <li><a href="/Farmstory1/community/notice.jsp">커뮤니티</a></li>

            </ul>
        </header>