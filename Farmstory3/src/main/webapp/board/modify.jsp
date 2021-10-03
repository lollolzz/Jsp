<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<jsp:include page="./_aside${group}.jsp"/>
<section id="board" class="modify">
    <h3>글수정</h3>
    <article>
        <form action="/Farmstory3/board/modify.do">
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" placeholder="${vo.title}"/></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="content">${vo.content}</textarea>                                
                    </td>
                </tr>
                <tr>
                    <td>첨부</td>
                    <td><input type="file" name="file"/></td>
                </tr>
            </table>
            <div>
                <a href="/Farmstory3/board/list.do?group=${group}&cate=${cate}" class="btnCancel">취소</a>
                <input type="submit"  class="btnWrite" value="수정완료">
            </div>
        </form>
    </article>
</section>

<!-- 내용 끝 -->
</article>
</section>
</div>
<%@ include file="../_footer.jsp" %>