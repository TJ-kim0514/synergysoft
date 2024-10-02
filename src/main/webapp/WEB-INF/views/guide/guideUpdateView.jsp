<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
	<%-- <%@ include file="../common/menubar.jsp" %> --%>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	
	<h2 align="center">${ guide.guidepostId } 번 공지글 수정페이지 (작성자용)</h2>
	<br>
	
	<form action="gupdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="noticeNo" value="${ notice.noticeNo }">
		
	
		<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
			<tr><th>제 목</th><td><input type="text" name="guideTitle" size="50" value="${ guide.guideTitle }"></td></tr>
			<tr><th>작성자</th><td><input type="text" name="guideWriter" readonly value="${ sessionScope.loginUser.userId }"></td></tr>
	
			<tr><th>내 용</th>
				<td><textarea rows="5" cols="50" name="noticeContent">${ guide.guideContent }</textarea></td>
			</tr>
			<tr><th colspan="2">
				<input type="submit" value="수정하기"> &nbsp;
				<input type="reset" value="수정취소"> &nbsp;
				<button onclick="javascript:location.href='${pageContext.servletContext.contextPath }/sagBlog.do'; return false;">목록</button> &nbsp;  
				<button onclick="javascript:history.go(-1); return false;">이전 페이지로 이동</button>
			</th></tr>
		</table>
	</form>
	
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>