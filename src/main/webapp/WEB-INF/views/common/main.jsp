<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
</nav>
<h1 align="center">안녕난 main.jsp야 각자 넣기 위치에 만들어서 넣어줘</h1>
<div class="container text-center">
  <div class="row">
    <div class="col">
      <h1>최근 공지사항 넣기</h1>
    </div>
    <div class="col">
      <h1>최근 QnA 넣기</h1>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <h1>인기 경로추천 넣기</h1>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <h1>인기 지역소담이 넣기</h1>
    </div>
  </div>
</div>
<footer>
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>