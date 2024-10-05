<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bonvoyage</title>
</head>
<body>
	<nav>
		<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
	</nav>
	<hr>
	<h1 align="center">회원 상세 조회</h1>
	<br>
	<form action="" method="post">
		<table align="center" width="1800px" cellSpacing="5" cellpadding="10" border="1">
			<tr colspan="2">
				<th>아이디</th>
				<td>${ member.memId }</td>
				
				<th>이름</th>
				<td>${ member.memName }</td>
				
				<th>닉네임</th>
				<td>${ member.memNickNm }</td>
				
				<th>타입</th>
				<td>${ member.memType }</td>
			</tr>
			
			<tr>
				<th>전화번호</th>
				<td>${ member.memPhone }</td>
				
				<th>생년월일</th>
				<td>${ member.memBirth }</td>
				
				<th>소셜구분</th>
				<td>${ member.memSocial }</td>
				
				<th>가입날짜</th>
				<td>${ member.memJoinDate }</td>
			</tr>
			
			<tr>
				<th>로그인기록</th>
				<td>${ member.memLoginLog }</td>
				
				<th>로그아웃기록</th>
				<td>${ member.memLogoutLog }</td>
				
				<th>사용자상태</th>
				<td>${ member.memStatus }</td>
				
				<th>상태적용날짜</th>
				<td>${ member.memStatusDate }</td>
				
				<th>비밀번호수정일</th>
				<td>${ member.memPwUpdate }</td>
			</tr>
		</table>
	</form>
	
	<hr>
	<footer>
		<c:import url="/WEB-INF/views/common/footer.jsp"/>	
	</footer>
</body>
</html>