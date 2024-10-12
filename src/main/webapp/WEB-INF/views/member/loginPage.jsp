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
			<label>아이디 : <input type="text" name="memId" id="memid" class="pos" required></label>
			<br>
			<label>비밀번호 : <input type="password" name="memPw" id="memPw" class="pos" required></label>
			<br>
			<center>
				<input type="submit" value="로그인">
			</center>
			<br>
		</form>
			<div class="container my-4" align="right">
			<a href="${pageContext.servletContext.contextPath }/idSearchPage.do">이메일 찾기</a> | 
			
			<div id="findPw" class="modal fade">
				<div class="modal-dialog modal-dialog-centered modal-login">
					<div class="modal-content">
						<div class="modal-body">
		
							<div class="container my-auto">
								<div class="row">
									<div class="card z-index-0 fadeIn3 fadeInBottom">
										<div
											class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
											<div
												class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
												<h4
													class="text-black font-weight-bolder text-center mt-2 mb-0">비밀번호 찾기</h4>
											</div>
										</div>
										<div class="card-body">
											<form role="form" class="text-start" action="/member/sendEmail"
												method="post" name="sendEmail">
												<p>입력한 이메일로 임시 비밀번호가 전송됩니다.</p>
												<div class="input-group input-group-outline my-3">
													<label class="form-label">Email</label>
													<input type="text" id="memId" name="memId" class="form-control" required>
												</div>
												<div class="text-center">
													<button type="button" class="btn bg-gradient-primary w-100 my-4 mb-2" id="checkEmail">비밀번호 발송</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<button type="button" class="btn btn-link" data-bs-toggle="modal"
				data-bs-target="#findPw">비밀번호 찾기</button>
			<script>
				$("#checkEmail").click(function () {
			        const memId = $("#memId").val();
			        const sendEmail = document.forms["loginPage.do"];
			        $.ajax({
			            type: 'post',
			            url: 'pwSearch.do',
			            data: {
			                'memId': memId
			            },
			            dataType: "text",
			            success: function (result) {
			                if(result == "no"){
			                    // 중복되는 것이 있다면 no == 일치하는 이메일이 있다!
			                    alert('임시비밀번호를 전송 했습니다.');
			                    sendEmail.submit();
			                }else {
			                    alert('가입되지 않은 이메일입니다.');
			                }
	
			            },error: function () {
			                console.log('에러 체크!!')
			            }
			        })
			    });
			</script> | 
			<c:url var="goEnroll" value="enrollPage.do" /> 
			<a href="${ goEnroll }">회원가입</a>
			</div>
			<div class="container my-4" align="center">
			<p>------------------- 또는 --------------------</p>
			<!-- 소셜로그인 -->
	 		<a href="javascript:loginWithKakao();"> 
				<img src="${pageContext.servletContext.contextPath }/resources/assets/img/Kakao.png" alt="카카오로고" />
			</a>
			<br>
			<a href="${ naverurl }">
				<img width="180" src="${pageContext.servletContext.contextPath }/resources/assets/img/Naver.png"/>
			</a>
			<br>
	 		<a href="${ googleurl }">
	 			<img src="${pageContext.servletContext.contextPath }/resources/assets/img/Google.png"/>
	 		</a>
	 		</div>
		<br>
	</div>
	<footer>
	<c:import url="/WEB-INF/views/common/footer.jsp"/>	
	</footer>
</body>
</html>