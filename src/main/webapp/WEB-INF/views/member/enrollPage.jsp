<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style type="text/css">
table th {
	background-color: #9ff;
}

table#outer {
	border: 2px solid navy;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function dupIdCheck() {
		$.ajax({
			url : 'idchk.do',
			type : 'post',
			data : {
				memId : $('#memId').val()
			},
			success : function(data) {
				console.log('success : ' + data);
				if (data == 'ok') {
					alert('사용 가능한 아이디입니다.');
					$('#memPw').focus();
				} else {
					alert('이미 사용중인 아이디입니다.');
					$('#memId').select();
				}
			},
			error : function(request, status, errorData) {
				console.log("error code : " + request.status + "\nMessage : "
						+ request.responseText + "\nError : " + errorData);
			}
		});
		return false;
	} // dupIdCheck()

	function validate() {
		var pwdValue = document.getElementById('memPw').value;
		var pwdValue2 = document.getElementById('memPw2').value;
		if (pwdValue !== pwdValue2) {
			alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
			document.getElementById('memPw').value = '';
			document.getElementById('memPw2').value = '';
			document.getElementById('memPw').focus();
			return false;
		}
		return true;
	} //validate()
</script>
</head>
<body>
	<%-- 메뉴바 표시 --%>
	<%@ include file="../common/menubar.jsp"%>
	<hr>

	<h1 align="center">회원가입 페이지</h1>
	<br>
	<form action="enroll.do" method="post" onsubmit="return validate();"
		enctype="multipart/form-data">
		<table id="outer" align="center" width="700" cellspacing="5"
			cellpadding="0">
			<tr>
				<th colspan="2">회원 정보를 입력해 주세요. (* 표시는 필수입력 항목입니다.)</th>
			</tr>
			<tr>
				<th width="120">*이메일</th>
				<td><input type="text" name="memId" id="memId" required>
					&nbsp; <input type="button" value="중복체크"
					onclick="return dupIdCheck();"></td>
			</tr>
			<tr>
				<th>*비밀번호</th>
				<td><input type="password" name="memPw" id="memPw" required></td>
			</tr>
			<tr>
				<th>*비밀번호 확인</th>
				<td><input type="password" id="memPw2" required></td>
			</tr>
			<tr>
				<th>*이 름</th>
				<td><input type="text" name="memName" id="memName" required></td>
			</tr>
			<tr>
				<th>*닉네임</th>
				<td><input type="text" name="memNickNm" id="memNickNm" required></td>
			</tr>
			<tr>
				<th>*생년월일</th>
				<td><input type="date" name="memBirth" required></td>
			</tr>
			<tr>
				<th>*전화번호</th>
				<td><input type="tel" name="memPhone" required></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="가입하기">
					&nbsp; <input type="reset" value="작성취소"> &nbsp; <a
					href="main.do">Home</a></th>
			</tr>
		</table>
	</form>

	<hr>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>