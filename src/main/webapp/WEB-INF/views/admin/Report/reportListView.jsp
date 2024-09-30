<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">신고목록</h1>
<br>
<center>
	<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
		<button onclick="javascript:locatior.href='${ pageContext.servletContext.contextPath}/rwrite.do';">공지글 등록</button>
	</c:if>
</center>
<br>

<%-- 조회된 공지사항 목록 출력 --%>
<table align="center" width="700" border="1" cellspacing="0" cellpadding="5">
	<tr>
		<th>번호</th>
		<th>게시글 제목</th>
		<th>신고 사유</th>
		<th>신고자</th>
		<th>날짜</th>
	</tr>
	<c:forEach items="${ requestScope.report }" var="r">
		<tr>
			<td align="center">${ r.reportId }</td>
			<td align="center">
				<a href="${ pageContext.servletContext.contextPath }/reportDetail.do?no=${ r.reportId }">${ r.postId }</a>
			</td>
			<td align="center">${ r.reportingReason }</td>
			<td align="center">익명</td>
			<td align="center">
				<fmt:formatDate value="${ r.reportDate }" pattern="yyyy-MM-dd" />
			</td>
		</tr>
	</c:forEach>
</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>