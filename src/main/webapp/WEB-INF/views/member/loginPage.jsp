<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- 카카오 로그인 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<style>
    #naver_id_login {
        display: block; /* 항상 보이도록 설정 */
        margin: 20px; /* 적절한 여백 추가 */
    }
</style>

<script type="text/javascript">
	$(document).ready(function(){
        Kakao.init('bcd1f6d5790735ccc553978585165423');
        Kakao.isInitialized();
    });
    function loginWithKakao() {
    	
        Kakao.Auth.authorize({ 
        redirectUri: 'http://localhost:8080/bonvoyage/kakaoLogin.do' 
        }); // 등록한 리다이렉트uri 입력
    }
</script>
<style type="text/css">
h1 {
	font-size: 48pt;
	color: navy;
}

div#loginForm {
	margin: auto;
	width: 500px;
	height: 400px;
	border: 2px solid navy;
	position: relative;
}

div#loginForm form {
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
</head>
<body>
	<nav>
	<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
	</nav>
	<br>
	<h1 align="center">본보야지 로그인 페이지</h1>
	<br>
	<div id="loginForm">
		<form action="login.do" method="post">
			<label>아이디 : <input type="text" name="memId" id="memid" class="pos"></label>
			<br>
			<label>비밀번호 : <input type="password" name="memPw" id="memPw" class="pos"></label>
			<br>
			<center>
				<input type="submit" value="로그인">
			</center>
			<br>
		</form>
		<ul class="list-unstyled">
			<li>
				<a href="${pageContext.servletContext.contextPath }/idSearchPage.do">아이디 찾기</a> | 
				<a href="${pageContext.servletContext.contextPath }/pwSearchPage.do">비밀번호 찾기</a> | 
				<c:url var="goEnroll" value="enrollPage.do" /> 
				<a href="${ goEnroll }">회원가입</a></li>
				<li>
				<p>------------------- 또는 --------------------</p>
				</li>
				<li>
					<!-- 소셜로그인 -->
					<ul class="sns">
						<li>
					 		<a href="javascript:loginWithKakao();"> 
								 <img src="${pageContext.servletContext.contextPath }/resources/assets/img/Kakao.png" width="80" height="80" alt="카카오로고" />
							</a>
						</li>
						<li>
					 		<%-- <%
							    String clientId = "GcBRifOkv0F3VVJTZbQd";//애플리케이션 클라이언트 아이디값";
							    String redirectURI = URLEncoder.encode("http://localhost:8080/bonvoyage/naverLogin.do", "UTF-8");
							    SecureRandom random = new SecureRandom();
							    String state = new BigInteger(130, random).toString();
							    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
							         + "&client_id=" + clientId
							         + "&redirect_uri=" + redirectURI
							         + "&state=" + state;
							    session.setAttribute("state", state);
							 %>  --%>
							  <a href="${ naverurl }"><img width="80" height="80" src="${pageContext.servletContext.contextPath }/resources/assets/img/Naver.png"/></a>
						</li>
						<li>
					 		<a href="${ googleurl }"><img width="80" height="80" src="${pageContext.servletContext.contextPath }/resources/assets/img/Google.png"/></a>
							<!-- <script>
							    function handleCredentialResponse(response) {
							      console.log("Encoded JWT ID token: " + response.credential);
							    }
							    window.onload = function () {
							      google.accounts.id.initialize({
							        client_id: "1026897669776-hk79tbpi0nihevh9li9vipn2ltgltaeb.apps.googleusercontent.com",
							        callback: handleCredentialResponse
							      });
							      google.accounts.id.renderButton(
							        document.getElementById("buttonDiv"),
							        { theme: "outline", size: "large" }  // customization attributes
							      );
							      google.accounts.id.prompt(); // also display the One Tap dialog
							    }
							</script> -->
						</li>
					</ul>
				</li>
			</ul>
		<br>
		<%-- <center>
			<a href="javascript:loginWithKakao();">
				<img alt="카카오로그인" src="${pageContext.request.contextPath}/resources/assets/img/kakao_login_medium_narrow.png">
			</a>
			<div id="naver_id_login"></div>
		    
		</center> --%>
	</div>
	<footer>
	<c:import url="/WEB-INF/views/common/footer.jsp"/>	
	</footer>
</body>
</html>