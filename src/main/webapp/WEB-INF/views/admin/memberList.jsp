<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bon voyage</title>
<script type="text/javascript" src="/first/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<h1 align="center">회원 리스트(작성중)</h1>
	<br><br>
	<table align="center" width="800" border="1" cellspacing="0" cellpadding="5">
		<tr>
			<th>이메일</th>
			<th>닉네임</th>
		</tr>
		<c:forEach items="${ requestScope.memberList }" var="member">
			<tr>
				<td align="center">${ member.memId }</td>
				<td align="center">${ member.memNickNm } &nbsp; <a href="${pageContext.servletContext.contextPath}/memberDetail.do?memId=${ member.memId }"  style="cursor: pointer;text-decoration:none;color:black;">상세보기</a></td>
			</tr>
		</c:forEach>
		<c:if test="${ empty member }">
			<td colspan="2" align="center">전체 회원 정보가 없습니다.</td>
		</c:if>
	</table>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</c:if>
	
<c:if test="${ empty sessionScope.loginUser or loginUser.memType eq 'USER' }">
	<% response.sendRedirect("main.do"); %>
</c:if>
</body>
</html>