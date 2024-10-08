<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 현재 페이지 변수 생성 --%>
<c:set var = "nowpage" value="1"/>
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage}"/>
</c:if>

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
			<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/reportWrite.do';">
				신고글 등록
			</button>
	</center>
	<br>

	<%-- 조회된 공지사항 목록 출력 --%>
	<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
		<table align="center" width="700" border="1" cellspacing="0"
			cellpadding="5">
			<tr align="center">
				<th>번호</th>
				<th>게시글 제목</th>
				<th>신고 사유</th>
				<th>신고자</th>
				<th>날짜</th>
			</tr>
			<c:forEach items="${ requestScope.report }" var="r">
				<tr align="center">
					<td>${ r.reportId }</td>
					<td><a href="${ pageContext.servletContext.contextPath }/reportDetail.do?no=${ r.reportId }">${ r.title }</a></td>
					<td>${ r.reportingReason }</td>
					<td>익명</td>
					<td><fmt:formatDate value="${ r.reportDate }"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<br>
	<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'USER' }">
		<table align="center" width="700" border="1" cellspacing="0"
			cellpadding="5">
			<tr align="center">
				<th>번호</th>
				<th>게시글 제목</th>
				<th>신고 사유</th>
				<th>신고자</th>
				<th>날짜</th>
			</tr>
			<c:forEach items="${ requestScope.report }" var="r">
				<c:if test="${ sessionScope.loginUser.memId eq r.reportUserId  }">
					<tr align="center">
						<td>${ r.reportId }</td>
						<td><a href="${ pageContext.servletContext.contextPath }/reportDetail.do?no=${ r.reportId }">${ r.title }</a></td>
						<td>${ r.reportingReason }</td>
						<td>${ r.reportUserId  }</td>
						<td><fmt:formatDate value="${ r.reportDate }"
								pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</c:if>
	<%-- 페이징 출력 뷰 포함 처리 --%>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>