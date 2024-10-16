<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>지역소담이 여행후기블로그</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }
    #main {
        margin-top: 30px;
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    h1 {
        font-size: 2.5rem;
        font-weight: bold;
        margin-bottom: 20px;
        color: #333;
    }
    table {
        width: 100%;
        border: 1px solid #dee2e6;
        margin-bottom: 20px;
    }
    th {
        background-color: #f1f1f1;
        font-weight: bold;
        text-align: left;
        padding: 10px;
    }
    td {
        padding: 10px;
        vertical-align: middle;
    }
    .btn-custom {
        background-color: #28a745;
        border-color: #28a745;
        color: white;
    }
    .btn-custom:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }
    .btn-group {
        margin-top: 20px;
        text-align: right;
    }
</style>
</head>

<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">

	function commentShow() {
	    var commentSection = document.getElementById("commentSection");
	    if (commentSection.style.display === "none") {
	        commentSection.style.display = "block";
	    } else {
	        commentSection.style.display = "none";
	    }
	}
	
    function enableEdit(rowId, contentId) {
        // 수정 버튼을 클릭했을 때 실행되는 함수
        var content = document.getElementById(contentId);
        var editButton = document.getElementById("editBtn_" + rowId);
        var deleteButton = document.getElementById("deleteBtn_" + rowId);
        var saveButton = document.getElementById("saveBtn_" + rowId);
        var cancelButton = document.getElementById("cancelBtn_" + rowId);

        // 내용 칸을 입력 가능한 <input> 필드로 변경
        content.innerHTML = '<input type="text" id="editContent_' + rowId + '" value="' + content.textContent + '" />';

        // 수정, 삭제 버튼을 숨기고 수정완료, 취소 버튼을 표시
        editButton.style.display = 'none';
        deleteButton.style.display = 'none';
        saveButton.style.display = 'inline';
        cancelButton.style.display = 'inline';
    }

    function saveEdit(rowId, commentId) {
        // 수정완료 버튼을 클릭했을 때 실행되는 함수
        var newContent = document.getElementById("editContent_" + rowId).value;

        // 여기에 AJAX 요청을 보내서 서버에 수정된 내용을 저장하도록 합니다.
        $.ajax({
            url: 'guideCommentEdit.do',
            type: 'POST',
            data: {
                commentId: commentId,
                content: newContent
            },
            success: function(response) {
                if (response === "Success") {
                    // 수정 성공 시 화면 업데이트
                    alert("댓글이 수정되었습니다.");
                    location.reload(); // 또는 화면의 특정 부분만 업데이트
                } else {
                    // 오류 발생 시 오류 메시지 표시
                    alert("수정 중 오류가 발생했습니다: " + response);
                }
            },
            error: function(error) {
                alert("통신 중 오류가 발생했습니다.");
            }
        });
    }

    function cancelEdit(rowId) {
        // 취소 버튼을 클릭했을 때 실행되는 함수
        // 원래 내용을 다시 보여주고 버튼 상태를 원래대로 돌립니다.
        var originalContent = document.getElementById("content_" + rowId).dataset.originalContent;
        document.getElementById("content_" + rowId).innerHTML = originalContent;
        toggleEditButtons(rowId, false);
    }

    function toggleEditButtons(rowId, isEditing) {
        // 수정 및 삭제 버튼을 보여주거나 숨기는 함수
        var editButton = document.getElementById("editBtn_" + rowId);
        var deleteButton = document.getElementById("deleteBtn_" + rowId);
        var saveButton = document.getElementById("saveBtn_" + rowId);
        var cancelButton = document.getElementById("cancelBtn_" + rowId);

        if (isEditing) {
            editButton.style.display = 'none';
            deleteButton.style.display = 'none';
            saveButton.style.display = 'inline';
            cancelButton.style.display = 'inline';
        } else {
            editButton.style.display = 'inline';
            deleteButton.style.display = 'inline';
            saveButton.style.display = 'none';
            cancelButton.style.display = 'none';
        }
    }
	
</script>

<script type="text/javascript">
    // 수정 페이지로 이동 버튼 클릭시 작동하는 함수
    function gmoveUpdatePage(){
        const guidepostId = '${ guide.guidepostId }';
        const url = '${ pageContext.servletContext.contextPath }/gmoveup.do?guidepostId=' + guidepostId;
        location.href = url;
    }
    
    // 삭제하기 버튼 클릭시 작동하는 함수
    function requestDelete(){
        const guidepostId = '${ guide.guidepostId }';
        const url = '${ pageContext.servletContext.contextPath }/gdelete.do?guidepostId=' + guidepostId;
        location.href = url;
    }
</script>


<c:url var="guideReport" value="guideReport.do">
	<c:param name="guidepostId" value="${ guide.guidepostId }" />
	<c:param name="userId" value="${ guide.guideUserId }" />
	<c:param name="title" value="${ guide.guideTitle }" />
</c:url>

<c:url var="guidelikecount" value="glikecount.do">
	<c:param name="postId" value="${ guide.guidepostId }" />
	<c:param name="userId" value="${ loginUser.memId }" />
</c:url>



<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container" id="main">
     <h3 class="text-center">${ guide.guideTitle }</h3>
    <br>
    
    <table class="table table-bordered">
        <tr>
            <th>제 목</th>
            <td>${ guide.guideTitle }</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${ guide.guideUserId }</td>
        </tr>
        <tr>
            <th>등록날짜</th>
            <td><fmt:formatDate value="${ guide.guideCreatedAt }" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>내 용</th>
            <td>${ guide.guideContent }</td>
        </tr>
        <tr>
        	<th>좋아요수</th>
        	<td>${ guide.likeCount }</td>
        </tr>
        
        <tr>
    <th>이미지</th>
    <td>
        <c:choose>
            <c:when test="${not empty guide.rFile1 || not empty guide.rFile2 || not empty guide.rFile3 || not empty guide.rFile4 || not empty guide.rFile5}">
                <div class="image-preview">
                    <!-- rFile1 이미지 출력 -->
                    <c:if test="${not empty guide.rFile1}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile1}" alt="첨부된 이미지 1" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile2 이미지 출력 -->
                    <c:if test="${not empty guide.rFile2}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile2}" alt="첨부된 이미지 2" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile3 이미지 출력 -->
                    <c:if test="${not empty guide.rFile3}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile3}" alt="첨부된 이미지 3" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile4 이미지 출력 -->
                    <c:if test="${not empty guide.rFile4}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile4}" alt="첨부된 이미지 4" style="max-width: 300px; margin-right: 10px;">
                    </c:if>

                    <!-- rFile5 이미지 출력 -->
                    <c:if test="${not empty guide.rFile5}">
                        <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile5}" alt="첨부된 이미지 5" style="max-width: 300px; margin-right: 10px;">
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <p>첨부된 이미지가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </td>
</tr>

        
        
        
        
    </table>

    <!-- 버튼 그룹 -->
    <div class="d-flex justify-content-end">
    <div class="btn-group">
    	
    	<button class="btn btn-outline-secondary" onclick="javascript:location.href='${ guidelikecount }'; return false;">❤️좋아요</button>
        <button class="btn btn-outline-secondary" onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/sagBlog.do';">목록</button>
        <button class="btn btn-secondary" onclick="javascript:history.go(-1);">이전 페이지로 이동</button>
        <button class="btn btn-secondary" onclick="commentShow(); return false;">댓글</button>
       <%--  <button class="btn btn-success" onclick="javascript:location.href='${ guideReport }'; return false;">신고</button> --%>
      <c:if test="${loginUser.memType eq 'ADMIN'}">
        <button class="btn btn-danger" onclick="requestDelete(); return false;">삭제</button>
    </c:if>
    </div>
    </div>
</div>

<!-- 댓글 부분 -->
<div class="text-center">
		
	
		
		
		</div>

<div class="container" style="display: none;" id="commentSection">
	<table class="table">
    <tr>
		<th style="text-align: center;" width="100">작성자</th>
        <th style="text-align: center;" width="900">내 용</th>
        <th style="text-align: center;" width="100">작성일자</th>
        <th></th>
    </tr>
       <c:forEach items="${ requestScope.clist1 }" var="g" varStatus="status">
        <tr>
            <td align="center">${ g.userId }</td>
            <td align="left" id="content_${ status.index }" data-original-content="${ g.content }">${ g.content }</td>
            <td align="center">${ g.createdAt }</td>
            <c:if test="${ g.userId eq loginUser.memId or loginUser.memType eq 'ADMIN' }">
	            <td align="center">
				<button class="btn btn-success" id="editBtn_${ status.index }" onclick="enableEdit('${ status.index }', 'content_${ status.index }'); return false;">수정싫어해</button>
				<c:url var="gcommentdelete" value="gcommentdelete.do">
	                 <c:param name="commentId" value="${ g.commentId }" />
	                 <c:param name="postId" value="${ guide.guidepostId }" />
	            </c:url>
				<button class="btn btn-success" id="deleteBtn_${ status.index }" onclick="javascript:location.href='${ gcommentdelete }'; return false;">삭제</button>
				<!-- 수정완료 버튼 -->
                <button class="btn btn-success" id="saveBtn_${ status.index }" style="display: none;" onclick="saveEdit('${ status.index }', '${ g.commentId }'); return false;">수정완료</button>
	                <!-- 취소 버튼 -->
                <button class="btn btn-success" id="cancelBtn_${ status.index }" style="display: none;" onclick="cancelEdit('${ status.index }'); return false;">취소</button>
	            </td>
            </c:if>
        </tr>
    </c:forEach>
	</table>
	
	<c:if test="${ !empty loginUser }">
	<div>
		<form action="guidecomment.do">
		<input type="hidden" name="postId" value="${ guide.guidepostId }">
		<input type="hidden" name="userId" value="${ sessionScope.loginUser.memId }">
		<table class="table">
		<tr>
		<td width="1100">
		<textarea name="content" rows="3" cols="140"></textarea>
		<!-- <input type="text" name="content" style="width: 1200px;"> -->
		</td>
		<td class="align-middle text-center">
		
		<input class="btn btn-success" type="submit"  value="등록">
		
		</td>
		</tr>
		</table>
		</form>
	</div>
</c:if>
</div> 






<!-- Footer Import -->
<c:import url="/WEB-INF/views/common/footer.jsp" />

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

</body>
</html>
