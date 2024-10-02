<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style type="text/css">
h1 {
	font-size: 48pt;
	color: navy;
}

div {
	margin: auto;
	width: 500px;
	height: 400px;
	border: 2px solid navy;
	position: relative;
}

div form {
	font-size: 16pt;
	color: navy;
	font-weight: bold;
	margin: 10px;
	padding: 10px;
}

div#loginForm form input.pos {
	position: absolute;
	left: 120px;
	width: 300px;
	height: 25px;
}

div#loginForm form input[type=submit] {
	margin: 10px;
	width: 250px;
	height: 40px;
	position: absolute;
	left: 120px;
	background-color: navy;
	color: white;
	font-size: 16pt;
	font-weight: bold;
}

div#loginForm label#forgotForm{
	margin: 10px;
	height: 40px;
	position: absolute;
	right: 0px;
	font-size: 11pt;
}

a#kakao-login-btn{
	margin: 10px;
	width: 250px;
	height: 20px;
	position: absolute;
	left: 120px;
}
</style>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	window.Kakao.init('bcd1f6d5790735ccc553978585165423');
	
	function loginWithKakao(){
		Kakao.Auth.login({
			success: function (res){
				Kakao.API.request({
					url: '/v2/user/me',
					data: {
						property_keys: ['id', 'kakao_account.email', 'properties.nickname'],
					},
					success: function (res){
						kakaoLoginPro(res);
						console.log(res);
						
						var token = Kakao.Auth.getAccessToken();
						Kakao.Auth.setAccessToken(token);
						console.log("token: " + token);
					},
					
					fail: function (error){
						alert('로그인에 실패하였습니다.');
					},
				})
			},
			fail: function (error) {
				location.href="${pageContext.servletContext.contextPath}/kakaoLogin.do";
			},
		})
	}
	
	function kakaoLoginPro(res){
		var kakao_kakaoId = res.id;
		var kakao_email = res.kakao_account.email;
		var kakao_name = res.properties.nickname;
		
		$.ajax({
			type : 'POST',
			url : '${pageContext.servletContext.contextPath}/kakaoLogin.do',
			data : {
				kakao_kakaoId,
				kakao_email,
				kakao_name
			},
			dataType : 'text',
			success : function(result){
				console.log("result : " + result);
				console.log("kakaoId : " + kakao_kakaoId);
				
				if(result == "Kakao_Login"){
					$('#kakaoId').val(kakao_kakaoId);
					$('#kakaoLoginForm').submit();
					alert("[Bonvoyage] 카카오톡으로 로그인을 시작합니다.");
				} else if(result == "Kakao_Enroll"){
					console.log("success : " + result);
					console.log(kakao_kakaoId);
					
					$('#kakao_kakaoId').val(kakao_kakaoId);
					$('#kakao_email').val(kakao_email);
					$('#kakao_name').val(kakao_name);
					$('#kakaoEnrollForm').submit();
					
					alert("[Bonvoyage] 카카오톡으로 가입을 시작합니다.");
				} else {
					alert("[Bonvoyage] 로그인에 실패했습니다.");
				}
			}, // success
			error: function(xhr, status, error){
				alert("[Bonvoyage] 로그인에 실패했습니다. " + error);
			}
		}); //ajax
	}; // kakaoLoginPro
</script>
</head>
<body>
	<h1 align="center">본보야지 로그인 페이지</h1>
	<div id="loginForm">
		<form action="login.do" method="post">
			<label>아이디 : <input type="text" name="memId" id="memid" class="pos"></label>
			<br>
			<label>비밀번호 : <input type="password" name="memPw" id="memPw" class="pos"></label>
			<br>
			<label id="forgotForm"><a>Forgot ID</a> | <a>Forgot Password</a></label>
			<center>
				<input type="submit" value="로그인">
			</center>
			<br>
		</form>
		<br>
		<!-- 소셜로그인 -->
		<center>
			<a id="kakao-login-btn" href="javascript:loginWithKakao()"> <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222" alt="카카오 로그인 버튼" /> </a>
		</center>
	</div>
</body>
</html>