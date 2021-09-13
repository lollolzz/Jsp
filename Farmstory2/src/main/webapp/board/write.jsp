<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%

	if( mb == null){
		response.sendRedirect("/Farmstory2/user/login.jsp");
	}

	String group		= request.getParameter("group");
	String cate			= request.getParameter("cate");
	String title		= request.getParameter("title");
	String uid 			= mb.getUid();
	
	String includeFile 	= "./_aside"+group+".jsp";
    // 뒤에 있는 / 와 . 사이에 있는 문자
%>



<jsp:include page="<%= includeFile %>">
	<jsp:param name="cate" value="<%= cate %>"/>
</jsp:include>
<section id="board" class="write">
    <h3>글쓰기</h3>
    <article>
        <form action="/Farmstory2/board/proc/writeProc.jsp" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="cate" value="<%=cate %>" />
        	<input type="hidden" name="group" value="<%=group %>" />
        	<input type="hidden" name="uid" value="<%= uid %>" />
        	<input type="hidden" name="title" value="<%= title %>" />
        	<!-- cate를 전송하기 위해 form 에 input을 해준것  -->
        	
        
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" placeholder="제목을 입력하세요."/></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="content"></textarea>                                
                    </td>
                </tr>
                <tr>
                    <td>첨부</td>
                    <td><input type="file" name="fname"/></td>
                </tr>
            </table>
            <div>
                <a href="/Farmstory2/board/list.jsp?group=<%=group %>&cate=<%= cate %>&uid=<%= uid %>" class="btnCancel">취소</a>
                <input type="submit"  class="btnWrite" value="작성완료">
            </div>
        </form>
    </article>
</section>