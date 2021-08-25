<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리</title>
    <link rel="stylesheet" href="/Farmstory1/css/style.css">
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
                <a href="/Farmstory1/user/login.jsp">로그인 |</a>
                <a href="/Farmstory1/user/register.jsp">회원가입 |</a>
                <a href="">고객센터 |</a>
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