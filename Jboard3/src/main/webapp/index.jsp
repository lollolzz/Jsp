<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.sessMember eq null}">
	<%-- sessionScope HttpSession에 등록된 데이터 이름과 값을 저장하고 있는 map객체 --%>
		<%-- 로그인 안했을때 --%>
		<jsp:forward page="/user/login.do"/>
	</c:when>

	<c:otherwise>
		<%-- 로그인 했을때--%>
		<jsp:forward page="/list.do"/>
	</c:otherwise>
</c:choose>


