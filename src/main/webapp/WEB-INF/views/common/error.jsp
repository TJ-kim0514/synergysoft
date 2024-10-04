<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage : error</title>
<!-- Bootstrap CSS CDN 링크 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
    }
    h1 {
        margin-top: 50px;
        color: #dc3545;
    }
    .container {
        text-align: center;
        margin-top: 50px;
    }
    nav, footer {
        margin: 20px 0;
    }
</style>
</head>
<body>
<nav>
    <c:import url="/WEB-INF/views/common/menubar.jsp"/>    
</nav>

<div class="container">
    <h1>오류 발생 : <%= request.getAttribute("message") %></h1>
    
    <div class="btn-container mt-4">
        <a href="javascript:history.go(-1);" class="btn btn-secondary btn-lg">이전 페이지로 이동</a>
        &nbsp;
        <a href="main.do" class="btn btn-primary btn-lg">Home</a>
    </div>
</div>

<footer>
    <c:import url="/WEB-INF/views/common/footer.jsp"/>    
</footer>

<!-- Bootstrap JS 및 Popper.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>