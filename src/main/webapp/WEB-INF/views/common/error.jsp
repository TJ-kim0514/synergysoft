<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first : error</title>
</head>
<body>
<h1>오류 발생 : <%= request.getAttribute("message") %></h1>
<a href="javascript:history.go(-1);">이전 페이지로 이동</a> &nbsp; <a href="main.do">Home</a>
</body>
</html>