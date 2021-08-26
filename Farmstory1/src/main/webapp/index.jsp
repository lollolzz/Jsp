<%@page import="Kr.co.Farmstory1.dao.ArticleDao"%>
<%@page import="Kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	ArticleDao dao = ArticleDao.getInstance();

 	List<ArticleBean> latestGrow = dao.selectLatest("grow");
 	List<ArticleBean> latestSchool = dao.selectLatest("school");
 	List<ArticleBean> latestStroy = dao.selectLatest("stroy");

%>
        <main>
            <div class="slider">
                <ul>
                    <!-- 애니메이션 처리하면 자동 슬라이드 되면서 그림이 바뀌는것을 구현 할거기 때문에
                    슬라이더가 3장이다 -->
                    <li><img src="./img/main_slide_img1.jpg" alt="슬라이더1"></li>
                    <li><img src="./img/main_slide_img2.jpg" alt="슬라이더1"></li>
                    <li><img src="./img/main_slide_img3.jpg" alt="슬라이더1"></li>
                </ul>
                <img src="./img/main_slide_img_tit.png" alt="사람과 자연을 사랑하는 팜스토리">
                <div class="banner">
                    <img src="./img/main_banner_txt.png" alt="GRAND OPEN"/>
                    <img src="./img/main_banner_tit.png" alt="팜스토리 오픈기념 30%할인 이벤트"/>
                    <img src="./img/main_banner_img.png" alt="과일"/>

                </div>
                <div class="float_banner">
                    <img src="./img/float_banner_tit.png" alt="팜카트 신청시 10% 적립혜택">
                </div>
                <div class="float_banner_b">
                    <img src="./img/float_banner_txt.png" alt="장보기">

                </div>
            </div>
            <div class="banner">
                <a href="#"><img src="./img/main_banner_sub1_tit.png" alt="오늘의 식단"></a>
                <a href="#"><img src="./img/main_banner_sub2_tit.png" alt="나도 요리사"></a>
            </div>
            <div class="latest">
                <article>
                    <a href="/Farmstory1/croptalk/grow.jsp"><img src="./img/main_latest1_tit.png" alt="텃밭가꾸기"></a>
                    <img src="./img/main_latest1_img.jpg" alt="이미지">
                    <table border="0">
                    <% for(ArticleBean article : latestGrow) { %>
                        <tr>
                            <td></td>
                            <td><a href="/Farmstory1/croptalk/grow.jsp?mode=v&seq=<%= article.getSeq() %>"><%=article.getTitle() %></a></td>
                            <td><%=article.getRdate().substring(2,10) %></td>
                       </tr>
                       <% } %>
                    </table>
                </article>
                <article>
                    <a href="/Farmstory1/croptalk/school.jsp"><img src="./img/main_latest2_tit.png" alt="귀농학교"></a>
                    <img src="./img/main_latest2_img.jpg" alt="이미지">
                    <table border="0">
                        <% for(ArticleBean article : latestSchool) { %>
                        <tr>
                            <td></td>
                            <td><a href="/Farmstory1/croptalk/school.jsp?mode=v&seq=<%= article.getSeq() %>"><%=article.getTitle() %></a></td>
                            <td><%=article.getRdate().substring(2,10) %></td>
                       </tr>
                       <% } %>
                   </table>
                </article>
                <article>
                    <a href="/Farmstory1/croptalk/stroy.jsp"><img src="./img/main_latest3_tit.png" alt="농작물이야기"></a>
                    <img src="./img/main_latest3_img.jpg" alt="이미지">
                    <table border="0">
                         <% for(ArticleBean article : latestStroy) { %>
                        <tr>
                            <td></td>
                            <td><a href="/Farmstory1/croptalk/Stroy.jsp?mode=v&seq=<%= article.getSeq() %>"><%=article.getTitle() %></a></td>
                            <td><%=article.getRdate().substring(2,10) %></td>
                       </tr>
                       <% } %>
                       </table>
                </article>

            </div>
            <div class="info">
        <div>
            <img src="./img/main_sub2_cs_tit.png" class="tit" alt="고객센터 안내"/>

            <div class="cs">
                <img src="./img/main_sub2_cs_img.png" alt="이미지"/>
                <img src="./img/main_sub2_cs_txt.png" alt="1666-777"/>
                <ul>
                    <li>평일: AM 09:00 ~ PM 06:00</li>
                    <li>점심: PM 12:00 ~ PM 01:00</li>
                    <li>토, 일요일, 공휴일 휴무</li>
                </ul>
            </div>

            <div class="btns">
                <a href="#"><img src="./img/main_sub2_cs_bt1.png" alt="고객문의"></a>
                <a href="#"><img src="./img/main_sub2_cs_bt2.png" alt="자주묻는질문"></a>
                <a href="#"><img src="./img/main_sub2_cs_bt3.png" alt="배송조회"></a>
            </div>
        </div>
        <div>
            <img src="./img/main_sub2_account_tit.png" class="tit" alt="계좌안내"/>
            <p class="account">
                기업은행 123-456789-01-01-012<br />
                국민은행 01-1234-56789<br />
                우리은행 123-456789-01-01-012<br />
                하나은행 123-456789-01-01<br />
                예 금 주 (주)팜스토리
            </p>
        </div>
        <div></div>
    </div>
</main>
<%@ include file="./_footer.jsp" %>
       