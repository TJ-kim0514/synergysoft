<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bon voyage</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">회원 리스트(작성중)</h1>
<br>
<center>
	<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
		<button onclick="javascript:locatior.href='${ pageContext.servletContext.contextPath}/admin/memberlist.do';">회원 목록</button>
	</c:if>
</center>
<br>
<table align="center" width="700" border="1" cellspacing="0" cellpadding="5">
	<tr>
		<th>순번</th>
		<th>이메일</th>
		<th>닉네임</th>
		<th>이름</th>
	</tr>
	<c:forEach items="${ requestScope.member }" var="member">
		<tr>
			<td align="center">${ member.memName }</td>
			<td align="center">${ member.memName }</td>
			<td align="center">${ member.memName }</td>
			<td align="center">${ member.memName }</td>
		</tr>
	</c:forEach>
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>