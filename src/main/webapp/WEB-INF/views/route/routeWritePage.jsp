<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style type="text/css">
	.routePlace {
		overflow-x: auto;
		white-space: nowrap;
  		position: absolute;
		left: 10%;
		top: 10%;
	}
	.routePlaceInsert {
		display: inline-block;
		
	}
	
	.routePlace input {
		width: 190px;
	}
	
	.routePlaceButton {
		
	}
	
</style>
</head>
<body>
<%-- <c:import url="/WEB-INF/views/common/menubar.jsp"/> --%>
<br>
<div>
	<h2 align="center">추천 경로 작성</h2>
	<form class="routePlace" action="inroute.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="userId" value="${ sessionScope.loginUser.memId }">
		<fieldset>
			<legend>제목</legend>
			<input type="text" style="width: 1630px; height: 30px; font-size: 13pt;" name="title">
		</fieldset>
		
		
		<fieldset class="routePlaceInsert">
		<legend>출발지</legend>
		 <table id="routePlace" align="center" width="300" cellspacing="3" cellpadding="0" class="routePlaceInsert">
		 	<tr><th width="100">주소</th>
		 		<td width="200">
		 			<input type="text" id="routePlaceAddress1" name="routePlaceAddress[]">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName1" name="routePlaceName[]">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto2" name="ofile11">
		 		</td>
		 	</tr>
		 	<tr><th>장소설명</th>
		 		<td>
		 			<textarea rows="5" cols="25" id="routePlaceContent1" name="routePlaceContent[]"></textarea>
		 		</td>
		 	</tr>
		 </table>
		 </fieldset>
		 
		 <fieldset class="routePlaceInsert">
		 <legend>경유지1</legend>
		 <table id="routePlace" align="center" width="300" cellspacing="3" cellpadding="0" class="routePlaceInsert">
		 	<tr><th width="100">주소</th>
		 		<td width="200">
		 			<input type="text" id="routePlaceAddress2" name="routePlaceAddress[]">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName2" name="routePlaceName[]">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto2" name="ofile22">
		 		</td>
		 	</tr>
		 	<tr><th width="100">장소설명</th>
		 		<td>
		 			<textarea rows="5" cols="25" id="routePlaceContent2" name="routePlaceContent[]"></textarea>
		 		</td>
		 	</tr>
		 </table>
		 </fieldset>

		 <fieldset class="routePlaceInsert">
		 <legend>경유지2</legend>
		 <table id="routePlace" align="center" width="300" cellspacing="3" cellpadding="0" class="routePlaceInsert">
		 	<tr><th width="100">주소</th>
		 		<td width="200">
		 			<input type="text" id="routePlaceAddress3" name="routePlaceAddress[]">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName3" name="routePlaceName[]">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto3" name="ofile33">
		 		</td>
		 	</tr>
		 	<tr><th width="100">장소설명</th>
		 		<td>
		 			<textarea rows="5" cols="25" id="routePlaceContent3" name="routePlaceContent[]"></textarea>
		 		</td>
		 	</tr>
		 </table>
		 </fieldset>
		 
		 <fieldset class="routePlaceInsert">
		 <legend>경유지3</legend>
		 <table id="routePlace" align="center" width="300" cellspacing="3" cellpadding="0" class="routePlaceInsert">
		 	<tr><th width="100">주소</th>
		 		<td width="200">
		 			<input type="text" id="routePlaceAddress4" name="routePlaceAddress[]">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName4" name="routePlaceName[]">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto4" name="ofile44">
		 		</td>
		 	</tr>
		 	<tr><th width="100">장소설명</th>
		 		<td>
		 			<textarea rows="5" cols="25" id="routePlaceContent4" name="routePlaceContent[]"></textarea>
		 		</td>
		 	</tr>
		 </table>
		 </fieldset>
		 
		 <fieldset class="routePlaceInsert">
		 <legend>목적지</legend>
		 <table id="routePlace" align="center" width="300" cellspacing="3" cellpadding="0" class="routePlaceInsert">
		 	<tr><th width="100">주소</th>
		 		<td width="200">
		 			<input type="text" id="routePlaceAddress5" name="routePlaceAddress[]">
		 		</td>
		 	</tr>
		 	<tr><th>이름</th>
		 		<td>
		 			<input type="text" id="routePlaceName5" name="routePlaceName[]">
		 		</td>
		 	</tr>
		 	<tr><th>장소사진첨부</th>
		 		<td>
		 			<input type="file" id="routePlacePhoto5" name="ofile55">
		 		</td>
		 	</tr>
		 	<tr><th width="100">장소설명</th>
		 		<td>
		 			<textarea rows="5" cols="25" id="routePlaceContent5" name="routePlaceContent[]"></textarea>
		 		</td>
		 	</tr>
		 </table>
		 </fieldset>
				 		 		 
		 <fieldset>
		 <legend>상세내용</legend>
		 <div>
		 	<textarea rows="20" cols="180" name="content" style="font-size: 13pt;"></textarea>
		 </div>
		 </fieldset>
		 <br>
		 
		 <input type="submit" value="등록하기"  class="routePlaceButton">
		 <input type="reset" value="작성취소" class="routePlaceButton">
		 <input type="button" value="뒤로가기" class="routePlaceButton" onclick="">
		 
	</form>
</div>	
<%-- <c:import url="/WEB-INF/views/common/footer.jsp"/> --%>
</body>
</html>