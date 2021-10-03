<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_header.jsp" %>
<link rel="stylesheet" href="/Farmstory3/css/style.css"/>
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
                <textarea readonly>${requestScope.vo.getTerms()}</textarea>
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
                <textarea readonly>${vo.privacy}</textarea>
                <p>
                    <label><input type="checkbox" name="chk2"/>동의합니다.</label>
                </p>
            </td>
        </tr>
    </table>
    <div>
        <a href="/Farmstory3/member/login.do">취소</a>
        <a href="/Farmstory3/member/register.do">다음</a>
    </div>
</section>
<%@ include file="../_footer.jsp" %>