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
<%-- 부트스트랩 css링크 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<%-- jQuery --%>
<script type="text/javascript" src="/first/resources/js/jquery-3.7.1.min.js"></script>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div>
    <h1>Q&A 게시판</h1>

    <%-- QnA 입력페이지 이동 --%>
        <div>
            <button onclick="window.location.href='miqna.do'">
                Q&A 작성
            </button>
        </div>
    <%-- 항목별 검색기능 --%>
    <form method="get" action="ssqna.do" id="ss">
        <select name="action" id="search">
            <option value="title" id="title">제목</option>
            <option value="userContent" id="userContent">내용</option>
            <option value="userId" id="userId">작성자</option>
        </select>
        <input type="search" name="keyword" placeholder="검색어를 입력해주세요" size="50">
        <button type="submit" >검색</button>
    </form>

    <%-- QnA 전체 테이블 --%>
    <div>
        <table>
            <thead>
                <tr>
                    <th width="80px">No</th>
                    <th width="500px">제목</th>
                    <th width="100px">작성자</th>
                    <th width="200px">등록일</th>
                    <th width="100px">비밀글 여부</th>
                    <th width="100px">답변여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.list}" var="q">
                    <tr>
                        <td>${fn:substring(q.qnaId, 4, -1)}</td>
                        <td>
                        	<c:if test="${ q.isSecret eq 'N'
                        				or( q.isSecret eq 'Y' and sessionScope.loginUser.memId eq q.userId)
                        				or( loginUser.memType eq 'ADMIN') }">
	                            <a href="${pageContext.servletContext.contextPath}/msqna.do?qnaId=${q.qnaId}">
	                                ${q.title}
	                            </a>
	                        </c:if>
	                        <c:if test="${ (q.isSecret eq 'Y' and sessionScope.loginUser.memId ne q.userId and loginUser.memType ne 'ADMIN')}">
	                                ${q.title}
	                        </c:if>
                        </td>
                        <td>${q.userId }</td>
                        <td>${q.qCreatedAt}</td>
                        <td>
                        	<c:if test="${q.isSecret eq 'Y'}">
                        		<input type="checkbox" checked disabled>
                       		</c:if>
                        	<c:if test="${q.isSecret eq 'N'}">
                        		<input type="checkbox" disabled>
                        	</c:if>
                        </td>
                        <td>
                         	<c:if test="${q.isAccept eq 'Y'}">
                        		<input type="checkbox" checked disabled>
                       		</c:if>
                        	<c:if test="${q.isAccept eq 'N'}">
                        		<input type="checkbox" disabled>
                        	</c:if>                       
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <%-- 페이징 출력 뷰 포함 처리 --%>
    <c:import url="/WEB-INF/views/common/pagingView.jsp" />

</div>

<hr>

<c:import url="/WEB-INF/views/common/footer.jsp" />

<!-- 부트스트랩 JS 링크 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>