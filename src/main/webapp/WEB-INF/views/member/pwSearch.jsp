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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>

	<h1 align="center">회원가입 페이지</h1>
	<!--임시 비번 모달-->
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
		data-bs-target="#findPw">비밀번호를 잊으셨나요?</button>
	<script>
		$("#checkEmail").click(function() {
			const userEmail = $("#memId").val();
			const sendEmail = document.forms["sendEmail"];
			$.ajax({
				type : 'post',
				url : 'pwSearch.do',
				data : {
					'memId' : userEmail
				},
				dataType : "text",
				success : function(result) {
					if (result == "no") {
						// 중복되는 것이 있다면 no == 일치하는 이메일이 있다!
						alert('임시비밀번호를 전송 했습니다.');
						sendEmail.submit();
					} else {
						alert('가입되지 않은 이메일입니다.');
					}

				},
				error : function() {
					console.log('에러 체크!!')
				}
			})
		});
	</script>
</body>
</html>