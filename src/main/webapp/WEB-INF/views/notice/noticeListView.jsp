<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 현재 페이지 변수 생성 --%>
<c:set var = "nowpage" value="1"/>
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage}"/>
</c:if>

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
	
<%-- 페이징 출력 뷰 포함 처리 --%>
<c:import url="/WEB-INF/views/common/pagingView.jsp"/>	
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</body>
</html>