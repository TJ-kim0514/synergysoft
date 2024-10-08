<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<style type="text/css">
	.place {
		width: 200px;
	}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<br>
<h2 align="center">상세보기 페이지</h2> <br>
<div>
<h4 align="center">${ route.title }</h4>
<br>
<div class="hstack gap-5 justify-content-center">
<table class="place">
	<tr><th style="width: 25%">주소</th><td>${ place[0].address }</td></tr>
	<tr><th>이름</th><td>${ place[0].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile1 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[0].placeContent }</td></tr>
</table>

<table class="place">
	<tr><th style="width: 25%">주소</th><td>${ place[1].address }</td></tr>
	<tr><th>이름</th><td>${ place[1].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile2 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[1].placeContent }</td></tr>
</table>

<table class="place">
	<tr><th style="width: 25%">주소</th><td>${ place[2].address }</td></tr>
	<tr><th>이름</th><td>${ place[2].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile3 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[2].placeContent }</td></tr>
</table>

<table class="place">
	<tr><th style="width: 25%">주소</th><td>${ place[3].address }</td></tr>
	<tr><th>이름</th><td>${ place[3].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile4 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[3].placeContent }</td></tr>
</table>

<table class="place">
	<tr><th style="width: 25%">주소</th><td>${ place[4].address }</td></tr>
	<tr><th>이름</th><td>${ place[4].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile5 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[4].placeContent }</td></tr>
</table>
</div>
<br>
<div class="hstack gap-1 justify-content-center">
<textarea readonly class="h-75 w-75 p-3" rows="20" cols="100">${ route.content }</textarea>
</div>
</div>













<br>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>