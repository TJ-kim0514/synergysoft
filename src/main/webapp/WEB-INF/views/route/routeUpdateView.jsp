<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<script type="text/javascript" src="${pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/routeFilePreview.js"></script>


</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<br>
<div>
	<h2 align="center">추천 경로 작성</h2>
	<form class="routePlace" action="uroute.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="userId" value="${ sessionScope.loginUser.memId }">
		<input type="hidden" name="routeBoardId" value="${ route.routeBoardId }">
		<input type="hidden" name="ofile1" value="${ route.ofile1 }">
		<input type="hidden" name="ofile2" value="${ route.ofile2 }">
		<input type="hidden" name="ofile3" value="${ route.ofile3 }">
		<input type="hidden" name="ofile4" value="${ route.ofile4 }">
		<input type="hidden" name="ofile5" value="${ route.ofile5 }">
		<input type="hidden" name="rfile1" value="${ route.rfile1 }">
		<input type="hidden" name="rfile2" value="${ route.rfile2 }">
		<input type="hidden" name="rfile3" value="${ route.rfile3 }">
		<input type="hidden" name="rfile4" value="${ route.rfile4 }">
		<input type="hidden" name="rfile5" value="${ route.rfile5 }">
		
		<div class="hstack gap-1 justify-content-center">
			제목 &nbsp;  <input type="text" style="width: 1630px; height: 30px; font-size: 13pt;" name="title" value="${ route.title }">
		</div>
		<br>
		<div class="hstack gap-0 justify-content-center">
		 <table>
		 	<tr><th width="150px">주소</th>
		 		<td>
		 			<input type="text" id="routePlaceAddress1" name="routePlaceAddress[]" value="${ place[0].address }">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName1" name="routePlaceName[]" value="${ place[0].placeName }">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto1" name="ofile11"  >
		 		</td>
		 	</tr>
		 	<tr>
		 	<td colspan="2" align="center">
		 	<div style="width: 200px; height: 200px;">
		 		<img id="photo1" src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile1 }" style="width: 200px; height: 200px;">
		 	</div>
		 	</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="3" cols="25" id="routePlaceContent1" name="routePlaceContent[]" >${ place[0].placeContent }</textarea>
		 		</td>
		 	</tr>
		 </table>

		 <table>
		 	<tr><th width="150px">주소</th>
		 		<td>
		 			<input type="text" id="routePlaceAddress2" name="routePlaceAddress[]" value="${ place[1].address }">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName2" name="routePlaceName[]" value="${ place[1].placeName }">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto2" name="ofile22"  >
		 		</td>
		 	</tr>
		 	<tr>
		 	<td colspan="2" align="center">
		 	<div style="width: 200px; height: 200px;">
		 		<img id="photo2" src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile2 }" style="width: 200px; height: 200px;">
		 	</div>
		 	</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="3" cols="25" id="routePlaceContent2" name="routePlaceContent[]" >${ place[1].placeContent }</textarea>
		 		</td>
		 	</tr>
		 </table>

		 <table>
		 	<tr><th width="150px">주소</th>
		 		<td>
		 			<input type="text" id="routePlaceAddress3" name="routePlaceAddress[]" value="${ place[2].address }">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName3" name="routePlaceName[]" value="${ place[2].placeName }">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto3" name="ofile33"  >
		 		</td>
		 	</tr>
		 	<tr>
		 	<td colspan="2" align="center">
		 	<div style="width: 200px; height: 200px;">
		 		<img id="photo3" src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile3 }" style="width: 200px; height: 200px;">
		 	</div>
		 	</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="3" cols="25" id="routePlaceContent3" name="routePlaceContent[]" >${ place[2].placeContent }</textarea>
		 		</td>
		 	</tr>
		 </table>

		 <table>
		 	<tr><th width="150px">주소</th>
		 		<td>
		 			<input type="text" id="routePlaceAddress4" name="routePlaceAddress[]" value="${ place[3].address }">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName4" name="routePlaceName[]" value="${ place[3].placeName }">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto4" name="ofile44"  >
		 		</td>
		 	</tr>
		 	<tr>
		 	<td colspan="2" align="center">
		 	<div style="width: 200px; height: 200px;">
		 		<img id="photo4" src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile4 }" style="width: 200px; height: 200px;">
		 	</div>
		 	</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="3" cols="25" id="routePlaceContent4" name="routePlaceContent[]" >${ place[3].placeContent }</textarea>
		 		</td>
		 	</tr>
		 </table>

		 <table>
		 	<tr><th width="150px">주소</th>
		 		<td>
		 			<input type="text" id="routePlaceAddress5" name="routePlaceAddress[]" value="${ place[4].address }">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName5" name="routePlaceName[]" value="${ place[4].placeName }">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto5" name="ofile55"  >
		 		</td>
		 	</tr>
		 	<tr>
		 	<td colspan="2" align="center">
		 	<div style="width: 200px; height: 200px;">
		 		<img id="photo5" src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile5 }" style="width: 200px; height: 200px;">
		 	</div>
		 	</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="3" cols="25" id="routePlaceContent5" name="routePlaceContent[]" >${ place[4].placeContent }</textarea>
		 		</td>
		 	</tr>
		 </table>
		</div>		 		 		 

		 <div class="hstack gap-1 justify-content-center">
		 	<textarea rows="20" cols="180" name="content" style="font-size: 13pt;">${ route.content }</textarea>
		 </div>
		 <br>
		 
		<div class="hstack gap-1 justify-content-center">
		 <input type="submit" value="수정하기"  class="routePlaceButton"> &nbsp;
		 <input type="reset" value="수정취소" class="routePlaceButton"> &nbsp;
		 <button onclick="javascript:history.go(-1); return false;">뒤로가기</button>
		</div>
	</form>
</div>	
<c:import url="/WEB-INF/views/common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>