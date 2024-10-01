<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>bon voyage</title>
  	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
    
    </head>
    <body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />
    
    <h1 align="center" >새 블로그 등록 페이지</h1>

<br>

<!-- form 에서 파일이 첨부되어서 전송이 될 경우에는 반드시 enctype="multipart/form-data" 속성을 추가해야 함(이거 추가 안하면 파일 전송 안감,. 파일 첨부 기능이 있으면 무조건 써야하는 속성임) -->
<form action=ginsert.do method="post" enctype="multipart/form-data">
<table id="outer" align="center" width="700" cellspacing="5" cellpadding="5">
	<tr><th width="120">제 목</th>
	<td>
		<input type="text" name="guideTitle" size="50">
	</td></tr>
	<tr><th width="120">작성자</th>
	<td>
		<!-- 로그인한 관리자 이름이 자동으로 작성자에 저장이된다. -->
		<input type="text" name="guideWriter" readonly value="${ sessionScope.loginUser.userId }">
	</td></tr>
	
	<tr><th width="120">지 역</th>
	<td>
		<input type="text" name="guideLocation" size="50">
		</td></tr>

	<tr><th>내 용</th>
	<td><textarea rows="5" cols="50" name="guideContent"></textarea>
	</td></tr>

	<tr><th colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
		<input type="reset" value="작성취소"> &nbsp;
		<input type="button" value="목록"  onclick="javascript:history.go(-1); return false;"> &nbsp;
		
	</th></tr>
</table>
</form>

	<div id="editor"></div>

	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<script type="text/javascript">
	const editor = new Editor({
		  el: document.querySelector('#editor'),
		  height: '600px',
		  initialEditType: 'markdown',
		  previewStyle: 'vertical'
		});
	</script>
  </body>
</html>