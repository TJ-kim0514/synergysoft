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
<script>
    // 파일 선택 시 이름을 업데이트하는 함수 (파일마다 구분)
    function updateFileName(fileNumber, input) {
        if (input.files[0]) {
            var fileName = input.files[0].name;
            document.getElementById('fileName' + fileNumber).textContent = fileName;
            // 파일이 선택되면 삭제 버튼을 보이게 함
            document.getElementById('deleteButton' + fileNumber).style.display = 'inline';
        }
    }

    // 파일 삭제 버튼을 눌렀을 때 처리하는 함수 (파일마다 구분)
    function deleteFile(fileNumber) {
        // 해당 파일 입력 필드를 초기화
        document.getElementById('insertFile' + fileNumber).value = null; 
        
        // 파일명을 빈 칸으로 설정
        document.getElementById('fileName' + fileNumber).textContent = null; 
        
        // 삭제 버튼을 다시 숨김
        document.getElementById('deleteButton' + fileNumber).style.display = 'none';
    }
</script>
</head>
<body>
<nav>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
</nav>
<br>
<form action="unotice.do" method="post" enctype="multipart/form-data">

<%-- 추가 input필요 데이터 --%>
<input type="hidden" name="noticeId" value="${ notice.noticeId }">
<input type="hidden" name="updateCheck" value="Y">
<input type="hidden" name="oFile1" value="${notice.oFile1}">
<input type="hidden" name="oFile2" value="${notice.oFile2}">
<input type="hidden" name="oFile3" value="${notice.oFile3}">
<input type="hidden" name="rFile1" value="${notice.rFile1}">
<input type="hidden" name="rFile2" value="${notice.rFile2}">
<input type="hidden" name="rFile3" value="${notice.rFile3}">
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
<tr>
    <td align="center">첨부파일1</td>
    <td colspan="3">
        <!-- 실제 파일 선택 input은 숨김 -->
        <input type="file" id="insertFile1" name="insertFile1" style="display: none;" onchange="updateFileName(1, this)">
        <!-- 파일 선택 버튼 -->
        <button type="button" onclick="document.getElementById('insertFile1').click()">파일 선택</button>
        <!-- 파일명 표시 -->
        <span id="fileName1">${notice.oFile1}</span> &nbsp;
        <!-- 삭제 버튼, 기존 파일이 있을 경우 표시 -->
        <input type="button" id="deleteButton1" name="delete" value="x" onclick="deleteFile(1)" style="display:${!empty notice.oFile1 ? 'inline' : 'none'};">
    </td>
</tr>
<tr>
    <td align="center">첨부파일2</td>
    <td colspan="3">
        <!-- 실제 파일 선택 input은 숨김 -->
        <input type="file" id="insertFile2" name="insertFile2" style="display: none;" onchange="updateFileName(2, this)">
        <!-- 파일 선택 버튼 -->
        <button type="button" onclick="document.getElementById('insertFile2').click()">파일 선택</button>
        <!-- 파일명 표시 -->
        <span id="fileName2">${notice.oFile2}</span> &nbsp;
        <!-- 삭제 버튼, 기존 파일이 있을 경우 표시 -->
        <input type="button" id="deleteButton2" name="delete" value="x" onclick="deleteFile(2)" style="display:${!empty notice.oFile2 ? 'inline' : 'none'};">
    </td>
</tr>
<tr>
    <td align="center">첨부파일3</td>
    <td colspan="3">
        <!-- 실제 파일 선택 input은 숨김 -->
        <input type="file" id="insertFile3" name="insertFile3" style="display: none;" onchange="updateFileName(3, this)">
        <!-- 파일 선택 버튼 -->
        <button type="button" onclick="document.getElementById('insertFile3').click()">파일 선택</button>
        <!-- 파일명 표시 -->
        <span id="fileName3">${notice.oFile3}</span> &nbsp;
        <!-- 삭제 버튼, 기존 파일이 있을 경우 표시 -->
        <input type="button" id="deleteButton3" name="delete" value="x" onclick="deleteFile(3)" style="display:${!empty notice.oFile3 ? 'inline' : 'none'};">
    </td>
</tr>
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