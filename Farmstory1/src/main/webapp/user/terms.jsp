<%@page import="Kr.co.Farmstory1.db.Sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Kr.co.Farmstory1.db.DBConfig"%>
<%@page import="java.sql.Connection"%>
<%@page import="Kr.co.Farmstory1.dao.ArticleDao"%>
<%@page import="Kr.co.Farmstory1.bean.TermsBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%

	TermsBean tb = new TermsBean();

	try{
		Connection conn = DBConfig.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_TERMS);
		if(rs.next()){
			tb.setTerms(rs.getString(1));
			tb.setPrivacy(rs.getString(2));
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}



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
        <a href="/Farmstory1/user/login.jsp">취소</a>
        <a href="/Farmstory1/user/register.jsp">다음</a>
    </div>
</section>
<%@ include file="../_footer.jsp" %>

        