<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<script type="text/javascript">
	function setSecretValue(checkbox){
		const hiddenField = document.querySelector('input[name="isSecret"]');
		hiddenField.value = checkbox.checked ? 'Y' : 'N' ;
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<br>
	<h1>Q&A 등록 페이지</h1>
	<br>
	<form action="iqna.do" method="post" enctype="multipart/form-data">
		<table >
			<tr>
			<td class="insert" >제목</td>
			<td><input type="text" name="title"></td>
			</tr>
			<tr>
			<td class="insert">작성자</td>
			<td><input type="text" name="userId" value="${ sessionScope.loginUser.memId }" readonly></td>
			</tr>
			<tr>
			<td class="insert">비밀글 여부</td>
			<td>
				<input type="hidden" name="isSecret" value="N">
				<input type="checkbox" id="isSecretCheckbox" value="Y" onclick="setSecretValue(this)">
			</td>
			</tr>
			<tr>
			<td class="insert">내용</td>
			<td><textarea cols="100" rows="10" name="userContent"></textarea></td>
			</tr>
			<c:forEach var="i" begin="1" end="5">
				<tr>
					<td class="insert">첨부파일</td>
					<td><input type="file" id="insertFile${i}" name="insertFile"></td>
				</tr>
			</c:forEach>					
			<tr><td colspan="2" align="center">
				<input type="submit" value="입력"> &nbsp;
				<input type="button" value="목록" onclick="javascript:history.go(-1);return false;">
			</td></tr>
		</table>
	</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>