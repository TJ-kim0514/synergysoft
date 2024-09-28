<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
</head>
<body>
	<h1>공지사항 등록 페이지</h1>
	<form action="inotice.do" method="post">
		<table border="1">
			<tr>
			<td>제목</td>
			<td><input type="text" name="title"></td>
			</tr>
			<tr>
			<td>작성자</td>
			<td><input type="text" name="adminId" value="${sessionScope.userId}" readonly></td>
			</tr>
			<tr>
			<td>내용</td>
			<td><textarea cols="100" rows="10" name="content"></textarea></td>
			</tr>
			<tr>
			<td>첨부파일1</td>
			<td><input type="file" name="file1"></td>
			</tr>
			</tr>
			<tr>
			<td>첨부파일2</td>
			<td><input type="file" name="file2"></td>
			</tr>
			</tr>
			<tr>
			<td>첨부파일3</td>
			<td><input type="file" name="file3"></td>
			</tr>
			<tr><input type="submit" value="입력">
		</table>
	</form>
</body>
</html>