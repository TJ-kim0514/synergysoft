<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 페이징 표시에 사용될 값들을 변수 선언 --%>
<c:set var="currentPage" value="${ requestScope.paging.currentPage }" />
<c:set var="urlMapping" value="${ requestScope.paging.urlMapping }" />
<c:set var="startPage" value="${ requestScope.paging.startPage }" />
<c:set var="endPage" value="${ requestScope.paging.endPage }" />
<c:set var="maxPage" value="${ requestScope.paging.maxPage }" />
<c:set var="groupLimit" value="${ requestScope.paging.groupLimit }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%-- 목록 페이징 처리 --%>
<div style="text-align:center;">
	<%-- 1page 로 이동 --%>
	<c:if test="${currentPage eq 1 }">
		[첫페이지로] &nbsp;
	</c:if>
	<c:if test="${currentPage gt 1 }">
		<a href = "/bonvoyage/${urlMapping }?page=1">[첫페이지로]</a>  &nbsp;
	</c:if>
	<%-- 이전 페이지그룹으로 이동 --%>
	<%-- 이전 그룹이 있다면  --%>
	<c:if test="${ (currentPage - groupLimit) lt startPage and (currentPage - groupLimit) gt 0 }">
		<a href="/bonvoyage/${ urlMapping }?page=${startPage-1}">[이전그룹]</a> &nbsp;
	</c:if>
	
	<%-- 이전 그룹이 없다면  --%>
	<c:if test="${ !((currentPage - groupLimit) lt startPage and (currentPage - groupLimit) gt 0) }">
	[이전그룹] &nbsp;
	</c:if>
	
	<%-- 현재 페이지 그룹 출력 and currentPage 표시 --%>
	<c:forEach begin="${startPage}" end ="${endPage}" step="1" var="p">
		<c:if test="${ p eq currentPage }">
			<font color="blue"size ="4"><b>${ p }</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<%-- <a href="${ pageContext.servletContext.contextPath }/${ urlMapping }">${ p }</a> --%>
			<a href="/bonvoyage/${ urlMapping }?page=${p}">${ p }</a>
			<%-- 예 : 페이지 7 클릭시 " href="/first/list.do?page=7" --%>
		</c:if>
		
	</c:forEach>
	
	
	<%-- 다음 페이지그룹으로 이동 --%>
	<%-- 다음 그룹이 있다면  --%>
	<c:if test="${ (currentPage + groupLimit) gt endPage and (currentPage + (maxPage%groupLimit)) le maxPage }">
		<a href="/bonvoyage/${ urlMapping }?page=${startPage+groupLimit}">[다음그룹]</a> &nbsp;
	</c:if>
	
	<%-- 다음 그룹이 없다면  --%>
	<c:if test="${ !((currentPage + groupLimit) gt endPage and (currentPage + (maxPage%groupLimit)) le maxPage ) }">
	[다음그룹] &nbsp;
	</c:if>
	
	<%-- maxPage 로 이동 --%>
		<%-- 1page 로 이동 --%>
	<c:if test="${currentPage ge maxPage }">
		[맨끝페이지로] &nbsp;
	</c:if>
	<c:if test="${currentPage lt maxPage }">
		<a href = "/bonvoyage/${urlMapping }?page=${maxPage}">[맨끝페이지로]</a> &nbsp;
	</c:if>
</div>
</body>
</html>