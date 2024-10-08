<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<script type="text/javascript">
	// 수정하기 버튼 함수
	function qupdate(qnaId){
		console.log(qnaId);
		location.href = "muqna.do?qnaId="+qnaId;
	}
	
    // 현재 noticeId를 가져옵니다. 
    const currentQnaId = parseInt('${fn:substring(qna.qnaId,4,-1)}');

    // 이전글 버튼 클릭 시 호출되는 함수
    function goToPrevious() {
        const previousQnaId = currentQnaId - 1; // 이전 글의 ID
        window.location.href = 'msqna.do?qnaId=qna_' + previousQnaId;
    }

    // 다음글 버튼 클릭 시 호출되는 함수
    function goToNext() {
        const nextQnaId = currentQnaId + 1; // 다음 글의 ID
        window.location.href = 'msqna.do?qnaId=qna_' + nextQnaId;	
    }
	
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<br>
	<h1>Q&A 상세보기</h1>
	<br>
	<c:if test="${ (sessionScope.loginUser.memId eq requestScope.qna.userId)
				and (requestScope.qna.isAccept eq 'N')}">
		<button id="qupdate"  onclick="qupdate(${qnaId})">수정하기</button>
	</c:if>
	<%-- 파일 다운용 url생성 --%>
	<c:url var="qfdown1" value="qfdown.do">
			<c:param name="oFile" value="${ qna.oFile1 }"/>
			<c:param name="rFile" value="${ qna.rFile1 }"/>
	</c:url>
	<c:url var="qfdown2" value="qfdown.do">
			<c:param name="oFile" value="${ qna.oFile2 }"/>
			<c:param name="rFile" value="${ qna.rFile2 }"/>
	</c:url>
	<c:url var="qfdown3" value="qfdown.do">
			<c:param name="oFile" value="${ qna.oFile3 }"/>
			<c:param name="rFile" value="${ qna.rFile3 }"/>
	</c:url>
	<c:url var="qfdown4" value="qfdown.do">
			<c:param name="oFile" value="${ qna.oFile4 }"/>
			<c:param name="rFile" value="${ qna.rFile4 }"/>
	</c:url>
	<c:url var="qfdown5" value="qfdown.do">
			<c:param name="oFile" value="${ qna.oFile5 }"/>
			<c:param name="rFile" value="${ qna.rFile5 }"/>
	</c:url>
		<table >
			<tr>
			<td class="insert" >제목</td>
			<td colspan="3">${ requestScope.qna.title }</td>
			</tr>
			<tr>
			<td class="insert">작성자</td>
			<td>${ requestScope.qna.userId }</td>
			<td class="insert">작성일</td>
			<td>${ requestScope.qna.qCreatedAt }</td>
			</tr>
			<tr>
			<td class="insert">비밀글 여부</td>
			<td>
				<c:if test="${ requestScope.qna.isSecret == 'Y'}">
					<input type="checkbox" id="isSecretCheckbox" checked disabled>
				</c:if>
				<c:if test="${ requestScope.qna.isSecret == 'N'}">
					<input type="checkbox" id="isSecretCheckbox"  disabled>
				</c:if>
			</td>
			</tr>
			<tr>
			<td class="insert">내용</td>
			<td colspan="3" style="white-space: pre-wrap;">${requestScope.qna.userContent }</td>
			</tr>
			<tr><td align="center" >첨부파일1</td><td colspan="3"><a href="${qfdown1}" >${qna.oFile1}</a></td></tr>
			<tr><td align="center" >첨부파일2</td><td colspan="3"><a href="${qfdown2}" >${qna.oFile2}</a></td></tr>
			<tr><td align="center" >첨부파일3</td><td colspan="3"><a href="${qfdown3}" >${qna.oFile3}</a></td></tr>
			<tr><td align="center" >첨부파일4</td><td colspan="3"><a href="${qfdown4}" >${qna.oFile4}</a></td></tr>
			<tr><td align="center" >첨부파일5</td><td colspan="3"><a href="${qfdown5}" >${qna.oFile5}</a></td></tr>			
			<c:if test="${ qna.isAccept eq 'N' }">
				<tr><td colspan="4">
					질문에 대한 답글이 없습니다.
				</td></tr>
			</c:if>
			<c:if test="${ qna.isAccept eq 'Y' }">
				<tr>
					<td>답변자</td>
					<td>${ qna.adminId }</td>
					<td>답변일</td>
					<td>${ qna.aCreatedAt }</td>
				</tr>
				<tr>
					<td>답변내용</td>
					<td colspan="3">${ qna.adminContent }</td>
				</tr>
			</c:if>
			<tr><td align="center" colspan="4">
				<button onclick="goToPrevious()">이전글</button>
				<button onclick="javascript:history.go(-1);">이전 페이지로 이동</button>
				<button onclick="javascript:location.href='${pageContext.servletContext.contextPath }/saqna.do'; return false;">목록</button>
				<button onclick="goToNext()">다음글</button>
			</td></tr>
		</table>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>