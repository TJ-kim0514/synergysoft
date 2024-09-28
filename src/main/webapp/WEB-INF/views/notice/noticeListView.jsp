<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
</head>
<body>
	<h1>공지사항 메인페이지</h1>
	<%-- 공지사항 입력페이지 이동 --%>
	<button onclick="window.location.href='minotice.do'">공지사항 쓰기</button>
	
	<%-- 공지사항 출력테이블 --%>
	<table>
		<tr>
			<th>글번호</th><th>제목</th><th>등록일</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="n">
			<tr>
				<td>${n.noticeId}</td>
				<td><a href="${pageContext.servletContext.contextPath}/msnotice.do?noticeId=${n.noticeId}">${n.title}</a></td>
				<td>${n.createdAt}</td>
			</tr>
		</c:forEach>
	</table>
	
	
</body>
</html>