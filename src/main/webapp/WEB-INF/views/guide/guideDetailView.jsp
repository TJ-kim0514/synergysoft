<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>가이드블로그 상세보기</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 30px;
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    h1 {
        font-size: 2.5rem;
        font-weight: bold;
        margin-bottom: 20px;
        color: #333;
    }
    table {
        width: 100%;
        border: 1px solid #dee2e6;
        margin-bottom: 20px;
    }
    th {
        background-color: #f1f1f1;
        font-weight: bold;
        text-align: left;
        padding: 10px;
    }
    td {
        padding: 10px;
        vertical-align: middle;
    }
    .btn-custom {
        background-color: #28a745;
        border-color: #28a745;
        color: white;
    }
    .btn-custom:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }
    .btn-group {
        margin-top: 20px;
        text-align: right;
    }
</style>
</head>

<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
    <h1 class="text-center">가이드블로그 상세보기</h1>
    <br>
    
    <table class="table table-bordered">
        <tr>
            <th>제 목</th>
            <td>${ guide.guideTitle }</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${ guide.guideUserId }</td>
        </tr>
        <tr>
            <th>등록날짜</th>
            <td><fmt:formatDate value="${ guide.guideCreatedAt }" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>내 용</th>
            <td>${ guide.guideContent }</td>
        </tr>
        
        <tr>
    <th>이미지</th>
    <td>
        <c:choose>
            <c:when test="${not empty guide.rFile1 || not empty guide.rFile2 || not empty guide.rFile3 || not empty guide.rFile4 || not empty guide.rFile5}">
                <div class="image-preview">
                    <!-- rFile1 이미지 출력 -->
                    <c:if test="${not empty guide.rFile1}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile1}" alt="첨부된 이미지 1" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile2 이미지 출력 -->
                    <c:if test="${not empty guide.rFile2}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile2}" alt="첨부된 이미지 2" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile3 이미지 출력 -->
                    <c:if test="${not empty guide.rFile3}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile3}" alt="첨부된 이미지 3" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile4 이미지 출력 -->
                    <c:if test="${not empty guide.rFile4}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile4}" alt="첨부된 이미지 4" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile5 이미지 출력 -->
                    <c:if test="${not empty guide.rFile5}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile5}" alt="첨부된 이미지 5" style="max-width: 300px; margin-right: 10px;">
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <p>첨부된 이미지가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </td>
</tr>

        
        
        
        
    </table>

    <!-- 버튼 그룹 -->
    <div class="btn-group">
        <button class="btn btn-custom me-md-2" onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/sagBlog.do';">목록</button>
        <button class="btn btn-secondary" onclick="javascript:history.go(-1);">이전 페이지로 이동</button>
    </div>
</div>

<hr>

<!-- Footer Import -->
<c:import url="/WEB-INF/views/common/footer.jsp" />

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

</body>
</html>
