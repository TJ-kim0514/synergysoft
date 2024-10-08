<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="rfile11" value="${ route.rfile1 }"  />
<c:set var="rfile22" value="${ route.rfile2 }" />
<c:set var="rfile33" value="${ route.rfile3 }" />
<c:set var="rfile44" value="${ route.rfile4 }" />
<c:set var="rfile55" value="${ route.rfile5 }" />
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
<c:url var="delroute" value="droute.do">
	<c:param name="no" value="${ route.routeBoardId }"></c:param>
	<c:param name="rfile11" value="${ route.rfile1 }"></c:param>
	<c:param name="rfile22" value="${ route.rfile2 }"></c:param>
	<c:param name="rfile33" value="${ route.rfile3 }"></c:param>
	<c:param name="rfile44" value="${ route.rfile4 }"></c:param>
	<c:param name="rfile55" value="${ route.rfile5 }"></c:param>
</c:url>
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
<br>
<table>
<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/moveUpdateRoute.do'; return false;">목록</button> &nbsp;
<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/moveUpdateRoute.do?no=${ route.routeBoardId }'; return false;">수정하기</button> &nbsp;
<button onclick="javascript:location.href='${ delroute }'; return false;">삭제하기</button>
</table>

</div>

<br>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>