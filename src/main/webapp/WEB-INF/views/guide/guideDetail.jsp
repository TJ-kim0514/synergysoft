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
        text-align: center;
    }
    .meta-info {
        font-size: 0.9rem;
        color: #777;
        margin-bottom: 30px;
    }
    .meta-info span {
        margin-right: 15px;
    }
    .content {
        font-size: 1.1rem;
        line-height: 1.7;
        color: #444;
        margin-bottom: 40px;
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
    .btn-danger {
        background-color: #dc3545;
        color: white;
    }
    .btn-danger:hover {
        background-color: #c82333;
    }
    .btn-group {
        text-align: right;
        margin-top: 20px;
    }
</style>

<script type="text/javascript">
    // 수정 페이지로 이동 버튼 클릭시 작동하는 함수
    function gmoveUpdatePage(){
        const guidepostId = '${ guide.guidepostId }';
        const url = '${ pageContext.servletContext.contextPath }/gmoveup.do?guidepostId=' + guidepostId;
        location.href = url;
    }
    
    // 삭제하기 버튼 클릭시 작동하는 함수
    function requestDelete(){
        const guidepostId = '${ guide.guidepostId }';
        const url = '${ pageContext.servletContext.contextPath }/gdelete.do?guidepostId=' + guidepostId;
        location.href = url;
    }
</script>

</head>

<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
    <!-- 제목 -->
    <h1>${ guide.guideTitle }</h1>

    <!-- 작성자와 날짜 -->
    <div class="meta-info">
        <span>작성자: ${ guide.guideUserId }</span>
        <span>등록날짜: <fmt:formatDate value="${ guide.guideCreatedAt }" pattern="yyyy-MM-dd" /></span>
    </div>

    <!-- 내용 -->
    <div class="content">
        ${ guide.guideContent }
    </div>

    <!-- 버튼 그룹 -->
    <div class="btn-group">
        <button class="btn btn-custom" onclick="gmoveUpdatePage(); return false;">수정</button>
        <button class="btn btn-danger" onclick="requestDelete(); return false;">삭제</button>
        <button class="btn btn-secondary" onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/sagBlog.do'; return false;">목록</button>
        <button class="btn btn-outline-secondary" onclick="javascript:history.go(-1); return false;">이전 페이지로</button>
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
