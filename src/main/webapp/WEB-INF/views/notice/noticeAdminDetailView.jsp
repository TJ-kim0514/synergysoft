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
<%-- 수정 url생성 --%>
<c:url var="noticeUpdate" value="munotice.do">
	<c:param name="noticeId" value="${notice.noticeId}"/>
</c:url>
<%-- 삭제 url생성 --%>
<c:url var="noticeDelete" value="dnotice.do">
	<c:param name="noticeId" value="${notice.noticeId}"/>
</c:url>
<script>
    // 현재 noticeId를 가져옵니다. 
    const currentNoticeId = parseInt('${fn:substring(notice.noticeId, 7,-1)}');

    // 이전글 버튼 클릭 시 호출되는 함수
    function goToPrevious() {
        const previousNoticeId = currentNoticeId - 1; // 이전 글의 ID
        window.location.href = 'msnotice.do?noticeId=notice_' + previousNoticeId;
    }

    // 다음글 버튼 클릭 시 호출되는 함수
    function goToNext() {
        const nextNoticeId = currentNoticeId + 1; // 다음 글의 ID
        window.location.href = 'msnotice.do?noticeId=notice_' + nextNoticeId;
    }
    
    // 수정페이지 url연결해주는 함수
    function moveUpdatePage(){
    	location.href="${noticeUpdate}";
    }
    // 삭제기능 url 연결해주는 함수
    function noticeDelete(){
    	location.href="${noticeDelete}";
    }
    
</script>


</head>
<body>
<nav>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
</nav>
<br>

<table align="center" width="800px" cellSpacing="5" cellpadding="10" border="1"  >
<tr><td colspan="4" align="center"><h4 align="center">${ notice.title }</h4></td></tr>
<tr>
	<td align="center" width="200px">작성자</td>
	<td align="center" width="200px">${notice.adminId}</td>
	<td align="center" width="200px">게시일</td>
	<td align="center" width="200px">${notice.createdAt}</td>
</tr>
<tr>
	<td align="center" >내용</td>
	<td colspan="3"> ${notice.content}</td>
</tr>
<tr>
<%-- 파일 다운용 url생성 --%>
<c:url var="nfdown1" value="nfdown.do">
			<c:param name="oFile" value="${ notice.oFile1 }"/>
			<c:param name="rFile" value="${ notice.rFile1 }"/>
</c:url>
<c:url var="nfdown2" value="nfdown.do">
			<c:param name="oFile" value="${ notice.oFile2 }"/>
			<c:param name="rFile" value="${ notice.rFile2 }"/>
</c:url>
<c:url var="nfdown3" value="nfdown.do">
			<c:param name="oFile" value="${ notice.oFile3 }"/>
			<c:param name="rFile" value="${ notice.rFile3 }"/>
</c:url>

<tr><td align="center" >첨부파일1</td><td colspan="3"><a href="${nfdown1}" >${notice.oFile1}</a></td></tr>
<tr><td align="center" >첨부파일2</td><td colspan="3"><a href="${nfdown2}" >${notice.oFile2}</a></td></tr>
<tr><td align="center" >첨부파일3</td><td colspan="3"><a href="${nfdown3}" >${notice.oFile3}</a></td></tr>
<tr><td align="center" colspan="3"> 
<button onclick="goToPrevious()">이전글</button>
<button onclick="javascript:history.go(-1);">이전 페이지로 이동</button>
<button onclick="javascript:location.href='${pageContext.servletContext.contextPath }/sanotice.do'; return false;">목록</button>
<button onclick="goToNext()">다음글</button>
</td>
<td>
<button onclick="moveUpdatePage(); return false;">수정</button>
<button onclick="noticeDelete(); return false;">삭제</button>
</td>
</tr>
</table>
		
		
<footer>
<c:import url="/WEB-INF/views/common/footer.jsp"/>	
</footer>

</body>
</html>