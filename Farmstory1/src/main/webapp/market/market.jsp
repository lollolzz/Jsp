<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mode = request.getParameter("mode");

	if(mode == null){
		mode = "l";
	}
	%>
<%@ include file="../_header.jsp" %>
 <div id="sub" class="cate2">
     <div><img src="../img/sub_top_tit2.png" alt="MARKET"></div>
     <section>
         <aside>
             <img src="../img/sub_aside_cate2_tit.png" alt="장보기"/>
             <ul>
                 <li class="on"><a href="./market.html">장보기</a></li>
             </ul>
         </aside>
         <article>
             <nav>
                 <img src="../img/sub_nav_tit_cate2_tit1.png" alt="장보기"/>
                 <p>
                     HOME > <strong>장보기</strong>
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