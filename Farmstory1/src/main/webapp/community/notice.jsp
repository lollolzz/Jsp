<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%
	String mode = request.getParameter("mode");

	if(mode == null){
		mode = "l";
	}
	%>
<%@ include file="../_header.jsp" %>
<div id="sub" class="cate5">
    <div><img src="/Farmstory1/img/sub_top_tit5.png" alt="COMMUNITY"></div>
    <section>
        <aside>
            <img src="/Farmstory1/img/sub_aside_cate5_tit.png" alt="커뮤니티"/>
            <ul>
                <li class="on"><a href="/Farmstory1/community/notice.jsp">공지사항</a></li>
                <li ><a href="/Farmstory1/community/menu.jsp">오늘의 식단</a></li>
                <li><a href="/Farmstory1/community/chef.jsp">나도요리사</a></li>
                <li><a href="/Farmstory1/community/qna.jsp">1:1고객문의</a></li>
                <li><a href="/Farmstory1/community/faq.jsp">자주묻는질문</a></li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/Farmstory1/img/sub_nav_tit_cate5_tit1.png" alt="공지사항"/>
                <p>
                    HOME > 커뮤니티 > <strong>공지사항</strong>
                </p>
            </nav>

			<!-- 내용 시작 -->
            <% if(mode.equals("l")){ %>
            	<jsp:include page="../board/list.jsp"/>
            <% }else if(mode.equals("w")){ %>
            	<jsp:include page="../board/write.jsp">
            		<jsp:param name="uid" value="<%= mb.getUid() %>"/>
            	</jsp:include>
            <% }else if(mode.equals("v")){ %>
            	<jsp:include page="../board/view.jsp">
            		<jsp:param name="uid" value="<%= mb.getUid() %>"/>
            	</jsp:include>
            <% }else if(mode.equals("m")){ %>
            	<jsp:include page="../board/modify.jsp">
            		<jsp:param name="uid" value="<%= mb.getUid() %>"/>
            	</jsp:include>
            <% } %>
             <!-- 위의 용법대로 사용한 param 형식으로 write페이지를 인클루드 해온다  -->	
            <!-- 내용 끝 --> 
            </article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>