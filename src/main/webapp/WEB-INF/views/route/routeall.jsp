<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav>
	<c:import url="/WEB-INF/views/common/menubar.jsp"/>
</nav>
<br>
<div>
<h1 align="center">경로 추천 게시판</h1>
<br>
<center>
    <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/moveWriteRoute.do';">글쓰기</button>
</center>
<br>
<table class="table table-bordered table-hover">
    <tr style="background-color: green;">
        <th style="text-align: center;" width="70">순 번</th>
        <th style="text-align: center;">제 목</th>
        <th style="text-align: center;" width="250">작성자</th>
        <th style="text-align: center;" width="200">작성일자</th>
        <th style="text-align: center;" width="100">좋아요</th>
    </tr>
    </thead>
    <tbody class="table-group-divider">
    <c:forEach items="${ requestScope.list }" var="r">
        <tr>
            <td align="center">${fn:substring(r.routeBoardId,6,-1)}</td>
            <td align="left"><a style="text-decoration: none; color: black;" href="${ pageContext.servletContext.contextPath }/routedetail.do?no=${ r.routeBoardId }">${ r.title }</a></td>
            <td align="center">${ r.userId }</td>
            <td align="center">${ r.createdAt }</td>
            <td align="center">${ r.likeCount }</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<footer>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>