<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
</head>
<body>
<nav>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
</nav>
<br>
<form action="unotice.do" method="post">

<%-- 추가 input필요 데이터 --%>
<input type="hidden" name="noticeId" value="${ notice.noticeId }">
<input type="hidden" name="updateCheck" value="Y">
<table align="center" width="800px" cellSpacing="5" cellpadding="10" border="1"  >
<tr><td align="center">제 목</td>
<td colspan="3" align="center">
	<textarea name="title" cols="75" rows="2" >${ notice.title }</textarea>
</td></tr>
<tr>
	<td align="center" width="200px">작성자</td>
	<td align="center" width="200px"><input name="adminId" readonly value="${notice.adminId}"></td>
	<td align="center" width="200px">게시일</td>
	<td align="center" width="200px"><input name="createdAt" readonly value="${notice.createdAt}"></td>
</tr>
<tr>
	<td align="center" >내용</td>
	<td colspan="3">
		<textarea name="content" rows="20" cols="75"> ${notice.content}</textarea>
	</td>
</tr>
<tr><td align="center" >첨부파일1</td><td colspan="3">${notice.file1}</td></tr>
<tr><td align="center" >첨부파일2</td><td colspan="3">${notice.file2}</td></tr>
<tr><td align="center" >첨부파일3</td><td colspan="3">${notice.file3}</td></tr>
<tr><td align="center" colspan="4"> 
<input type="submit" value="수정"> &nbsp;
<button onclick="javascript:history.go(-1); return false;">수정취소</button> &nbsp;
<button onclick="javascript:location.href='${pageContext.servletContext.contextPath}/sanotice.do'; return false;">목록</button>
</td>
</tr>
</table>
</form>		
		
<footer>
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</footer>

</body>
</html>