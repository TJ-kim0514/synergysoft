<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

.notice-button {
    position: relative;
    left: 60%;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 10px 15px;
    cursor: pointer;
    font-size: 16px;
}

.notice-button:hover {
    background-color: #0056b3; /* 호버 시 더 어두운 색상 */
}

.notice-table {
    width: 80%;
    margin: auto;
    border-collapse: collapse;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.notice-table th, .notice-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

.notice-table th {
    background-color: #f0f0f0;
    font-weight: bold;
}

.notice-link {
    text-decoration: none;
    color: black;
}

.notice-link:hover {
    text-decoration: underline; /* 호버 시 링크에 밑줄 추가 */
}
</style>
</head>
<body>
<nav>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
</nav>

<br>
	<h1 align="center">공지사항</h1></p>
	<%-- 공지사항 입력페이지 이동 --%>
	<c:if test="${!empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
	<button onclick="window.location.href='minotice.do'" style="position:relative;left:60%; ">공지사항 쓰기</button>
	<%-- location.href= "/first/moveWriter.do"; --%>
	</c:if>
	
	<%-- 공지사항 출력테이블 --%>
	<div align="center">
	<table>
		<tr align="center">
			<th width="80px" >글번호</th>
			<th width="500px">제목</th>
			<th width="200px">등록일</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="n">
			<tr >
				<td align="center">${fn:substring(n.noticeId,7,-1)}</td>
				<td > <a href="${pageContext.servletContext.contextPath}/msnotice.do?noticeId=${n.noticeId}" style="cursor: pointer;text-decoration:none;color:black;">${n.title}</a></td>
				<td align="center">${n.createdAt}</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
<%-- 페이징 출력 뷰 포함 처리 --%>
<c:import url="/WEB-INF/views/common/pagingView.jsp"/>
<hr> <%--footer --%>
<footer>
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</footer>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
</body>
</html>