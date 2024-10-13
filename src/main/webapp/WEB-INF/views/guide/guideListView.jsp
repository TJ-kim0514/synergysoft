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
<title>Bonvoyage</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1 class="text-center">가이드블로그 메인페이지</h1>





<%-- 항목별 검색 기능 추가 --%>

	<%-- 검색 항목별 값 입력 전송용 폼 만들기 --%>
<!-- 통합 검색 폼 -->
<!-- <div style="display: flex; justify-content: flex-end;"> -->
<!-- 목록 버튼은 폼 외부로 -->
<div class="row">
    <!-- 검색 폼을 왼쪽에 배치 -->
    <div class="col text-end">
        <form action="${pageContext.request.contextPath}/gsearch.do" method="get" style="display: inline-block; margin-right: 10px;"> <!-- 오른쪽 여백 추가 -->
            <fieldset>
                <!-- 검색 기준 선택 -->
                <select name="action" class="form-select" style="width: 150px; display: inline-block;">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="location">지역</option>
                </select>
                <!-- 검색어 입력 -->
                <input type="search" name="keyword" size="50" class="form-control d-inline-block" style="width: auto;" placeholder="제목 또는 내용 또는 지역을 입력해주세요.">
                <!-- 검색 버튼 -->
                <input type="submit" value="검색" class="btn btn-success">
            </fieldset>
        </form>
        
        <!-- 목록 버튼을 검색 폼 오른쪽에 배치 -->
        <button class="btn btn-success" style="border-radius: 50px; margin-right: 10px;" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/sagBlog.do?page=1';">목록</button>
        <button class="btn btn-success" style="border-radius: 50px; margin-right: 10px;" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/chattingPage.do';">채팅</button>
    </div>
</div>


	

<div class="container my-5">
    <!-- 블로그 쓰기 버튼 -->
    <button class="btn btn-success mb-4" onclick="javascript:location.href='${pageContext.servletContext.contextPath}/gmoveWrite.do';">블로그 쓰기</button>

    <!-- 블로그 카드 목록 -->
<div class="row row-cols-1 row-cols-md-3 g-4">
    <!-- 블로그 정보를 반복문으로 출력 -->
    <c:forEach items="${list}" var="g">
        <div class="col">
            <div class="card h-100">
                <!-- rFile1이 있으면 해당 이미지를, 없으면 기본 이미지를 출력 -->
                <c:choose>
                    <c:when test="${not empty g.rFile1}">
                    <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${g.rFile1}?v=${System.currentTimeMillis()}" alt="이미지" />
                    
                       <%--  <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${g.rFile1}" class="card-img-top" alt="블로그 이미지" style="max-width: 100%; height: auto;"> --%>
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/300x150" class="card-img-top" alt="기본 이미지" style="max-width: 100%; height: auto;">
                    </c:otherwise>
                </c:choose>
                <div class="card-body">
                    <h5 class="card-title">${g.guideTitle}</h5>
                    <p class="card-text">지역: ${g.guideLocation}</p>
                    <p class="card-text">조회수: ${g.likeCount}</p>
                   
                    
    
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
