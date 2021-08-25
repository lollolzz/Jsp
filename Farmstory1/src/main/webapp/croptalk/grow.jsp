<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%
	String mode = request.getParameter("mode");

	if(mode == null){
		mode = "l";
	}
	%>
<%@ include file="../_header.jsp" %>
<div id="sub" class="cate3">
    <div><img src="/Farmstory1/img/sub_top_tit3.png" alt="CROPTALK"></div>
    <section>
        <aside>
            <img src="/Farmstory1/img/sub_aside_cate3_tit.png" alt="농작물이야기"/>
            <ul>
                <li><a href="/Farmstory1/croptalk/stroy.jsp">농작물이야기</a></li>
                <li  class="on"><a href="/Farmstory1/croptalk/grow.jsp">텃밭가꾸기</a></li>
                <li><a href="/Farmstory1/croptalk/school.jsp">귀농이야기</a></li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/Farmstory1/img/sub_nav_tit_cate3_tit2.png" alt="텃밭가꾸기"/>
                <p>
                    HOME > 농작물이야기 > <strong>텃밭가꾸기</strong>
                </p>
            </nav>

            <!-- 내용 시작 -->
           <% if(mode.equals("l")){ %>
           		<jsp:include page="../board/list.jsp"/>
           <% }else if(mode.equals("w")){ %>
           		<jsp:include page="../board/write.jsp"/>
     	   <% } else if(mode.equals("v")){ %>
     	   		<jsp:include page="../board/view.jsp"/>
	   	   <% } else if(mode.equals("m")){ %>
	   	   		<jsp:include page="../board/modify.jsp"/>
	   	   <% } %>	

            <!-- 내용 끝 -->
        </article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>