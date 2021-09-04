<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate 	= request.getParameter("cate");
	// 팜스토리 페이지의 martket부분에 접속했을때의 cate를 db로 부터 받아오는 듯
	String title	= "";
	
	if(cate.equals("market")){
		title = "장보기";
	}
%>
<div id="sub" class="cate2">
    <div><img src="/Farmstrory3/img/sub_top_tit2.png" alt="MARKET"></div>
    <section>
        <aside>
            <img src="/Farmstrory3/img/sub_aside_cate2_tit.png" alt="장보기"/>
            <ul>
                <li class="<%= cate.equals("market") ? "on" : "off" %>"><a href="./list.jsp?grooup=Market&cate=market">농작물이야기</a></li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/Farmstrory3/img/sub_nav_tit_cate2_<%= cate %>.png" alt="<%= title %>"/>
                <p>
                    HOME > 장보기 > <strong><%= title %></strong>
                </p>
            </nav>

            <!-- 내용 시작 -->
