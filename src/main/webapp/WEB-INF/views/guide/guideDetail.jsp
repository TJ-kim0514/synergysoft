<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%-- 요청 url 을 따로 지정 --%>
<c:url var="gup" value="gmoveup.do">
	<c:param name="guidepostId" value="${ guide.guidepostId }" />
</c:url>

<c:url var="gdel" value="gdelete.do">
	<c:param name="guidepostId" value="${ guide.guidepostId }" />

</c:url>

<script type="text/javascript">
	//수정 페이지로 이동 버튼 클릭시 작동하는 함수
	function gmoveUpdatePage(){
		location.href='${ gup }';
	}
	
	//삭제하기 버튼 클릭시 작동하는 함수
	function requestDelete(){
		location.href='${ gdel }';
	}
	</script>
	</head>
	<body>


<c:import url="/WEB-INF/views/common/menubar.jsp" />
<h1 class="text-center">가이드블로그 상세보기페이지</h1>

<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td>${ guide.guideTitle }</td></tr>
	<tr><th>작성자</th><td>${ guide.guideUserId }</td></tr>
	<tr><th>등록날짜</th>
		<td><fmt:formatDate value="${ guide.guideCreatedAt }" pattern="yyyy-MM-dd" /></td></tr>

	
	<tr><th>내 용</th><td>${ guide.guideContent }</td></tr>
	<tr><th colspan="2">
	<button onclick="gmoveUpdatePage(); return false;">수정페이지로 이동</button> &nbsp; 
	<button onclick="requestDelete(); return false;">삭제하기</button> &nbsp; 
		<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/sagBlog.do';">목록</button>
		<button onclick="javascript:history.go(-1);">이전 페이지로 이동</button>
	</th></tr>
	
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>