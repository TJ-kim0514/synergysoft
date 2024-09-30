<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<h1 class="text-center">가이드블로그 메인페이지</h1>

<div class="container my-5">
    <!-- 블로그 쓰기 버튼 -->
    <button class="btn btn-success mb-4" onclick="javascript:location.href='${pageContext.servletContext.contextPath}/moveWrite.do';">블로그 쓰기</button>

    <!-- 블로그 카드 목록 -->
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <!-- 블로그 정보를 반복문으로 출력 -->
        <c:forEach items="${guideList}" var="g">
        <div class="col">
            <div class="card h-100">
                <img src="https://via.placeholder.com/300x150" class="card-img-top" alt="블로그 이미지">
                <div class="card-body">
                    <h5 class="card-title">${g.guideTitle}</h5>
                    <p class="card-text">블로그번호: ${g.guidepostId}</p>
                    <p class="card-text">지역: ${g.guideLocation}</p>
                    <p class="card-text">추천 수: ${g.likeCount}</p>
                    <a href="${pageContext.servletContext.contextPath}/viewGuide.do?guidepostId=${g.guidepostId}" class="btn btn-primary">상세보기</a>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>

 

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

</body>
</html>
