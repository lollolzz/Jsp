<%@page import="kr.co.Farmstory2.dao.MemberDao"%>
<%@page import="kr.co.Farmstory2.bean.TermsBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	TermsBean tb = MemberDao.getInstance().selectTerms();

%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    	$(document).ready(function(){
    		
    		var btnNext = $('.terms > div > a:nth-child(2)');
    		
    		btnNext.click(function(){
    			
    			var isChecked1 = $('input[name=chk1]').is(':checked');
    			var isChecked2 = $('input[name=chk2]').is(':checked');
    			
    			if(!isChecked1 || !isChecked2){
    				alert('동의 체크를 하셔야 합니다.');
    				return false;
    			}else{
    				return true;	
    			}
    		});
    	});
 </script>
<section id="user" class="terms">
    <table>
        <caption>사이트 이용약관</caption>
        <tr>
            <td>
                <textarea readonly><%= tb.getTerms() %></textarea>
                <p>
                    <label><input type="checkbox" name="chk1"/>동의합니다.</label>
                </p>
            </td>
        </tr>
    </table>
    <table>
        <caption>개인정보 취급방침</caption>
        <tr>
            <td>
                <textarea readonly><%= tb.getPrivacy() %></textarea>
                <p>
                    <label><input type="checkbox" name="chk2"/>동의합니다.</label>
                </p>
            </td>
        </tr>
    </table>
    <div>
        <a href="/Farmstory2/user/login.jsp">취소</a>
        <a href="/Farmstory2/user/register.jsp">다음</a>
    </div>
</section>
<%@ include file="../_footer.jsp" %>

        