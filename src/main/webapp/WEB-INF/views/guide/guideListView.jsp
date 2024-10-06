<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1 class="text-center">가이드블로그 메인페이지</h1>

<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/sagBlog.do?page=1';">목록</button> &nbsp; &nbsp;


<%-- 항목별 검색 기능 추라 --%>

	<%-- 검색 항목별 값 입력 전송용 폼 만들기 --%>
<%-- 제목 검색 폼 --%>
<form action="gsearchTitle.do" id="titleform" class="sform" method="get">
	<input type="hidden" name="action" value="title">
	<fieldset>
	<legend>검색할 제목을 입력하세요.</legend>
		<input type="search" name="keyword" size="50"> &nbsp;
		<input type="submit" value="검색">
	</fieldset>
</form>


<form action="gsearchContent.do" id="contentform" class="sform" method="get">
	<input type="hidden" name="action" value="content">
	<fieldset>
	<legend>검색할 내용을 입력하세요.</legend>
		<input type="search" name="keyword" size="50"> &nbsp;
		<input type="submit" value="검색">
	</fieldset>
</form>


<form action="gsearchLocation.do" id="contentform" class="sform" method="get">
	<input type="hidden" name="action" value="content">
	<fieldset>
	<legend>검색할 지역을 입력하세요.</legend>
		<input type="search" name="keyword" size="50"> &nbsp;
		<input type="submit" value="검색">
	</fieldset>
</form>
	

<div class="container my-5">
    <!-- 블로그 쓰기 버튼 -->
    <button class="btn btn-success mb-4" onclick="javascript:location.href='${pageContext.servletContext.contextPath}/gmoveWrite.do';">블로그 쓰기</button>

    <!-- 블로그 카드 목록 -->
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <!-- 블로그 정보를 반복문으로 출력 -->
        <c:forEach items="${list}" var="g">
        <div class="col">
            <div class="card h-100">
                <img src="https://via.placeholder.com/300x150" class="card-img-top" alt="블로그 이미지">
                <div class="card-body">
                    <h5 class="card-title">${g.guideTitle}</h5>
                    <p class="card-text">지역: ${g.guideLocation}</p>
                    <p class="card-text">추천 수: ${g.likeCount}</p>
    
                    <a href="${pageContext.servletContext.contextPath}/gdetail.do?guidepostId=${g.guidepostId}" class="btn btn-dark">상세보기</a>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>

 

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<%-- 페이징 출력 뷰 포함 처리 --%>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
	
	
</body>
</html>
