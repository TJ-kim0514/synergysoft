<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <a href="main.do" style="font-family: Arial, sans-serif; font-size:30px; font-weight: bold; color: #a0c9bb; text-decoration: none; text-shadow:2px 2px 2px #4ba483; margin-left: 20px;">
   Bon Voyage
    </a>
      <ul class="navbar-nav me-auto mx-auto "  >
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="routeall.do">경로추천</a>
        </li>
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="sagBlog.do">지역소담이</a>
        </li>
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="#">지도</a>
        </li>
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="sanotice.do">공지사항</a>
        </li>
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="saqna.do">Q&A</a>
        </li>
        <li class="nav-item" style="width:120px;text-align:center;">
          <a class="nav-link active" aria-current="page" href="reportList.do">신고</a>
        </li>
      </ul>
      <div id="islogin">
      </div>
      
      <c:if test="${ empty sessionScope.loginUser }">
         <button type="button" class="btn btn-outline-success" onclick="location.href='loginPage.do'">로그인</button> &nbsp;
         <button type="button" class="btn btn-outline-success" onclick="location.href='enrollPage.do'">회원가입</button>
      </c:if>
      <c:if test="${ !empty sessionScope.loginUser }">
      	<button type="button" class="btn btn-outline-success" onclick="location.href='myinfo.do?memId=${loginUser.memId}'">마이페이지</button> &nbsp;
         <button type="button" class="btn btn-outline-success" onclick="location.href='logout.do'">로그아웃</button>
      </c:if>
      
    </div>
  </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>