<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>

<c:url var="reportUpdateProcess" value="reportUpdateProcess.do">
	<c:param name="checkedAdminId" value="${ loginUser.memId }" />
	<c:param name="assignedAdminId" value="${ loginUser.memId }" />
	<c:param name="reportId" value="${ report.reportId }" />
</c:url>

<c:url var="reportUpdateReject" value="reportUpdateReject.do">
	<c:param name="checkedAdminId" value="${ loginUser.memId }" />
	<c:param name="assignedAdminId" value="${ loginUser.memId }" />
	<c:param name="reportId" value="${ report.reportId }" />
</c:url>

<c:url var="reportDelete" value="reportDelete.do">
	<c:param name="reportId" value="${ report.reportId }" />
</c:url>

<script type="text/javascript">
//수정 페이지로 이동 버튼 클릭시 작동하는 함수
function requestUpdateProcess(){
	location.href = "${ reportUpdateProcess }";
}

function requestUpdateReject(){
	location.href = "${ reportUpdateReject }";
}

//삭제하기 버튼 클릭시 작동하는 함수
function requestDelete(){
	location.href = "${ reportDelete }";
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h2 align="center">${ report.reportId } 번 신고글 상세보기</h2>
<br>
<table align="center" width="700" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td>${ report.postId }</td></tr>
	<tr><th>등록날짜</th>
		<td><fmt:formatDate value="${ report.reportDate }" pattern="yyyy-MM-dd" /></td></tr>
	<tr><th>신고내용</th><td>${ report.reportingReason }</td></tr>
	<tr><th>신고상세내용</th><td>${ report.detail }</td></tr>
	<tr><th colspan="2">
		<button onclick="requestUpdateProcess(); return false;">처리하기</button>  &nbsp; 
		<button onclick="requestUpdateReject(); return false;">반려하기</button>  &nbsp; 
		<button onclick="requestDelete(); return false;">삭제하기</button>  &nbsp; 
		<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/reportList.do';">목록</button> &nbsp;  
		<button onclick="javascript:history.go(-1); return false;">이전 페이지로 이동</button>
	</th></tr>
</table>


<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>










