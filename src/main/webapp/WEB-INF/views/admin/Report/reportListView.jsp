<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- 현재 페이지 변수 생성 --%>
<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage}" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

.report-table th, .report-table td {
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

<script type="text/javascript"
	src="/first/resources/js/jquery-3.7.1.min.js"></script>

</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div class="container">
		<h1 align="center" class="text-center my-4">신고목록</h1>

		<div class="text-end mb-3">
			<button align="center" class="btn btn-primary"
				style="background-color: #4ba483; color: white;"
				onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/reportWrite.do';">
				신고글 작성</button>
		</div>
		<%-- 항목별 검색기능 --%>
		<%-- 따로 수정 예정 --%>
		<form method="get" action="reportSearch.do"
			class="d-flex justify-content-center mb-4" id="ss">
			<select name="action" id="search" class="form-select w-auto">
				<option value="reportingReason" id="reportingReason">제목</option>
				<option value="detail" id="detail">내용</option>
			</select> <input type="search" name="keyword" class="form-control mx-2" placeholder="검색어를 입력해주세요" size="50">
			<button type="submit" class="btn btn-primary"
				style="background-color: #4ba483; color: white;">검색</button>
		</form>
		<%-- 조회된 신고글 목록 출력 --%>
		<div class="table-responsive">
			<table class="table table-striped table-bordered report-table">
				<thead class="table-primary">
					<tr class="text-center">
						<th width="80px" style="background-color: #4ba483; color: white;">번호</th>
						<th width="500px" style="background-color: #4ba483; color: white;">신고사유</th>
						<th width="100px" style="background-color: #4ba483; color: white;">작성자</th>
						<th width="100px" style="background-color: #4ba483; color: white;">날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ requestScope.list }" var="r">
						<tr>
							<td class="text-center">${ r.reportId }</td>
							<td><a
								href="${ pageContext.servletContext.contextPath }/reportDetail.do?reportId=${ r.reportId }"
								class="text-dark text-decoration-none">${ r.reportingReason }</a></td>
							<td class="text-center">${ r.reportUserId }</td>
							<td class="text-center"><fmt:formatDate
									value="${ r.reportDate }" pattern="yyyy-MM-dd" /></td>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>