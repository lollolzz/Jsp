<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uid = request.getParameter("uid");
	//게시판이 참조 되어있는 각페이지마다 include-w 삽입되어 있는 곳에
	// write페이지에서 받은 uid를 각페이지에 삽입
	String uri = request.getRequestURI();
	// 여기서의 uri는 l,v,w..등이 삽이 되어져있는 각페이지 마다 에서 글쓰기 작업을 할때
	// 그 페이지의 uri를 받아오는 것이다 
	int start 	= uri.lastIndexOf("/") +1;
    // lastIndexOf 뒤쪽에 있는 문자열을 앞에서 부터 숫자세어서 찾는기능 
    // 제일 뒤에있는 해당 문자를 찾는 기능 
    int end 	= uri.lastIndexOf(".");
    
    String cate = uri.substring(start, end);
    // 뒤에 있는 / 와 . 사이에 있는 문자
	
%>
<section id="board" class="write">
    <h3>글쓰기</h3>
    <article>
        <form action="/Farmstory1/board/proc/writeProc.jsp" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="cate" value="<%=cate %>" />
        	<!-- cate를 전송하기 위해 form 에 input을 해준것  -->
        	<input type="hidden" name="uid" value="<%=uid %>" /> 
        	<input type="hidden" name="uri" value="<%=uri %>" />  
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
                <a href="<%= uri %>" class="btnCancel">취소</a>
                <input type="submit"  class="btnWrite" value="작성완료">
            </div>
        </form>
    </article>
</section>