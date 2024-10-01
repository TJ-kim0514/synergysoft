<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
	<h1>테스트</h1>
	<a href ="routeall.do">경로</a>
	<a href ="sanotice.do">공지사항</a>
	<a href ="saqna.do">qna</a>
	<a href ="loginPage.do">로그인</a>
	<a href ="enrollPage.do">회원가입</a>
	<a href ="sagBlog.do">가이드</a>
	<a href ="myinfo.do?memId=${ sessionScope.loginUser.memId }">회원</a>
	<a href ="reportList.do">신고</a>
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</body>
</html>