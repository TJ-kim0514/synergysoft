<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
</head>
<body>

	<h1 align="center">경로 추천 게시판</h1>
	<br>

	<table align="center" width="1000" border="1" cellspacing="0" cellpadding="0">
		<tr>
			<th>제 목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>좋아요</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="n">
			<tr>
				<td align="center">${ n.content }</td>
				<td align="center">${ n.userId }</td>
				<td align="center">${ n.createdAt }</td>
				<td align="center">${ n.likeCount }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>