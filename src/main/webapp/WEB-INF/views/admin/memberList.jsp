<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bon voyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/first/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<div class="container my-5">
	<c:if test="${ !empty sessionScope.loginUser and loginUser.memType eq 'ADMIN' }">
		<h1 align="center">회원 리스트</h1>
		<br><br>
		<fieldset>
			<form method="get" action="memberListSearch.do" class="d-flex mb-4" id="ss" style="float:left">
		        <select name="action" id="searchItem" class="form-select w-auto">
		            <option value="memId" id="memId">아이디</option>
		            <option value="memNickNm" id="memNickNm">닉네임</option>
		            <option value="memName" id="memName">이름</option>
		        </select>
		        <input type="search" name="keyword" class="form-control d-inline-block" style="width: auto;" placeholder="검색어를 입력해주세요" size="80">
		        <button type="submit" class="btn btn-success">검색</button>
		    </form>
	    </fieldset>
		<div class="row row-cols-1 row-cols-md-4 g-5">
		<c:forEach items="${memberList}" var="memberList">
			<div class="col">
				<div class="card text-center" style="width: 18rem;">
					<div class="card-body">
						<h5 class="card-title">${ memberList.memNickNm }</h5>
						<p class="card-text">${ memberList.memId }</p>
						<a href="${pageContext.servletContext.contextPath}/memberDetail.do?memId=${ memberList.memId }" class="btn btn-primary">상세보기</a>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</c:if>
</div>

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

<c:if test="${ empty sessionScope.loginUser or loginUser.memType eq 'USER' }">
	<% response.sendRedirect("main.do"); %>
</c:if>
<c:import url="/WEB-INF/views/common/pagingView.jsp"/>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>