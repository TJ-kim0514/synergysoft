<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style type="text/css">
	table th{ background-color: #9ff, }
	table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript">
	function validate(){
		var pwdValue = document.getElementById('userPwd').value;
		var pwdValue2 = document.getElementById('userPwd2').value;
		if(pwdValue !== pwdValue2){
			alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
			document.getElementById('userPwd').value = '';
			document.getElementById('userPwd2').value = '';
			document.getElementById('userPwd').focus();
			return false;
		}
		return true;
	}  //validate()
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<h1 align="center">내 정보 보기 페이지</h1>
	<br>
	<form action="myinfo/update.do" onsubmit="return validate();" method="post">
	
		<input type="hidden" name="originalMemPw" value="${ requestScope.member.memPw }">
		
		<table id="outer" align="center" width="700" cellspacing="5px" cellpadding="0">
			
			<tr>
				<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.memType eq 'ADMIN' }">
					<th colspan="2"><h3><b>[ 관리자 ] ${ loginUser.memNickNm }님 반갑습니다.</b></h3></th>
				</c:if>
				
				<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.memType eq 'USER' }">
					<th colspan="2"><h3><b>[ 유저 ] ${ loginUser.memNickNm }님 반갑습니다.</b></h3></th>
				</c:if>
			</tr>
			
			<tr>
				<th width="120">이메일</th>
				<td>
					<input type="text" name="memId" id="memId" value="${ requestScope.member.memId }" readonly>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="memPw" id="memPw"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="memPwChk"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="memName" id="memName" value="${ requestScope.member.memName }" readonly>				
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="memNickNm" id="memNickNm" value="${ requestScope.member.memNickNm }">				
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="date" name="memBirth" value="${ requestScope.member.memBirth }" readonly>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="tel" name="memPhone" value="${ requestScope.member.memPhone }">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="수정하기"> &nbsp;
					<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.memType eq 'ADMIN' }">
						<a href="admin/memberList.do">관리자페이지</a> &nbsp;
					</c:if>
					<c:url var="mdel" value="myinfo/left.do">
						<c:param name="memId" value="${ requestScope.member.memId }" />
					</c:url>
					<a href="${ mdel }">탈퇴하기</a> &nbsp;
					<a href="main.do">Home</a>
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>