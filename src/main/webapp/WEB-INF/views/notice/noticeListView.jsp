<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- 현재 페이지 변수 생성 --%>
<c:set var="nowpage" value="1" />
<c:if test="${!empty requestScope.currentPage}">
    <c:set var="nowpage" value="${requestScope.currentPage}" />
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<!-- 부트스트랩 CSS 링크 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .notice-table th, .notice-table td {
        vertical-align: middle;
    }
    footer {
        text-align: center;
        padding: 20px 0;
        font-size: 0.9rem;
        color: #666;
        background-color: #f1f1f1;
        margin-top: 30px;
    }
</style>

<script type="text/javascript" src="/first/resources/js/jquery-3.7.1.min.js"></script>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
    <h1 class="text-center my-4">공지사항</h1>

    <%-- 공지사항 입력페이지 이동 --%>
    <c:if test="${!empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
        <div class="text-end mb-3">
            <button class="btn btn-primary" style="background-color:#4ba483;color:white;" onclick="window.location.href='minotice.do'">
                공지사항 작성
            </button>
        </div>
    </c:if>

    <%-- 항목별 검색기능 --%>
    <form method="get" action="ssnotice.do" class="d-flex justify-content-center mb-4" id="ss">
        <select name="action" id="search" class="form-select w-auto">
            <option value="title" id="title">제목</option>
            <option value="content" id="content">내용</option>
        </select>
        <input type="search" name="keyword" class="form-control mx-2" placeholder="검색어를 입력해주세요" size="50">
        <button type="submit" class="btn btn-primary" style="background-color:#4ba483;color:white;">검색</button>
    </form>

    <%-- 공지사항 출력 테이블 --%>
    <div class="table-responsive">
        <table class="table table-striped table-bordered notice-table">
            <thead class="table-primary">
                <tr class="text-center">
                    <th width="80px" style="background-color:#4ba483;color:white;">No</th>
                    <th width="500px" style="background-color:#4ba483;color:white;" >제목</th>
                    <th width="200px" style="background-color:#4ba483;color:white;" >등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.list}" var="n">
                    <tr>
                        <td class="text-center">${fn:substring(n.noticeId, 7, -1)}</td>
                        <td>
                            <a href="${pageContext.servletContext.contextPath}/msnotice.do?noticeId=${n.noticeId}" class="text-dark text-decoration-none">
                                ${n.title}
                            </a>
                        </td>
                        <td class="text-center">${n.createdAt}</td>
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