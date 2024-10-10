<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">

/* 	// 댓글 출력
	$(function(){
		$.ajax({
			url:'commentShow.do',
			type:'post',
			dataType:'json',
			success:function(data){
				console.log('success : '+data);
				
				var str = JSON.stringify(data);
				
				var json = JSON.parse(str);
				
				values = '';
				for(var i in json.nlist){
					
					values += '<tr><td>' + decodeURIComponent(json.clist[i].userId)
					+'</td><td align="left">' + decodeURIComponent(json.clist[i].content).replace(/\+/gi,' ')
					+'</a></td><td>'+json.clist[i].createAt + '</td></tr>';
				}
				
				$('#commentlist').html($('#commentlist').html()+values);
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log('error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
			}
		})
	}); */

	function commentShow() {
	    var commentSection = document.getElementById("commentSection");
	    if (commentSection.style.display === "none") {
	        commentSection.style.display = "block";
	    } else {
	        commentSection.style.display = "none";
	    }
	}
</script>


<c:url var="delroute" value="droute.do">
	<c:param name="no" value="${ route.routeBoardId }" />
	<c:param name="rfile11" value="${ route.rfile1 }" />
	<c:param name="rfile22" value="${ route.rfile2 }" />
	<c:param name="rfile33" value="${ route.rfile3 }" />
	<c:param name="rfile44" value="${ route.rfile4 }" />
	<c:param name="rfile55" value="${ route.rfile5 }" />
</c:url>

<c:url var="routelikecount" value="rlikecount.do">
	<c:param name="postId" value="${ route.routeBoardId }" />
	<c:param name="userId" value="${ loginUser.memId }" />
</c:url>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<br>
<h2 align="center">상세보기 페이지</h2> <br>
<div>
<h4 align="center">${ route.title }</h4>
<br>
<button onclick="javascript:location.href='${ routelikecount }'; return false;">추천</button>
<div class="hstack gap-5 justify-content-center container">



<table>
	<tr><th style="width: 25%">주소</th><td>${ place[0].address }</td></tr>
	<tr><th>이름</th><td>${ place[0].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile1 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[0].placeContent }</td></tr>
</table>

<table>
	<tr><th style="width: 25%">주소</th><td>${ place[1].address }</td></tr>
	<tr><th>이름</th><td>${ place[1].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile2 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[1].placeContent }</td></tr>
</table>

<table>
	<tr><th style="width: 25%">주소</th><td>${ place[2].address }</td></tr>
	<tr><th>이름</th><td>${ place[2].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile3 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[2].placeContent }</td></tr>
</table>

<table>
	<tr><th style="width: 25%">주소</th><td>${ place[3].address }</td></tr>
	<tr><th>이름</th><td>${ place[3].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile4 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[3].placeContent }</td></tr>
</table>

<table>
	<tr><th style="width: 25%">주소</th><td>${ place[4].address }</td></tr>
	<tr><th>이름</th><td>${ place[4].placeName }</td></tr>
	<tr><th>사진</th></tr>
	<tr>
	<td>
	<div width="200" height="200">
	<img src="${ pageContext.servletContext.contextPath }/resources/route_upfiles/${ route.rfile5 }" style="width: 200px; height: 200px;">
	</div>
	</td>
	</tr>
	<tr><th>소개</th><td>${ place[4].placeContent }</td></tr>
</table>
</div>
<br>
<div class="hstack gap-1 justify-content-center">
<textarea readonly class="h-75 w-75 p-3" rows="20" cols="100">${ route.content }</textarea>
</div>
<br>
<table>
<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/moveUpdateRoute.do'; return false;">목록</button> &nbsp;
<c:if test="${ sessionScope.loginUser.memId eq route.userId }">
	<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/moveUpdateRoute.do?no=${ route.routeBoardId }'; return false;">수정하기</button> &nbsp;
	<button onclick="javascript:location.href='${ delroute }'; return false;">삭제하기</button>
</c:if>
</table>
</div>
<br>

<button onclick="commentShow(); return false;">댓글</button>
<div style="display: none;" id="commentSection">
	<table id="">
    <tr>
		<th style="text-align: center;" width="250">작성자</th>
        <th style="text-align: center;">내 용</th>
        <th style="text-align: center;" width="200">작성일자</th>
    </tr>
       <c:forEach items="${ requestScope.clist }" var="c">
        <tr>
            <td align="center">${ c.userId }</td>
            <td align="left">${ c.content }</td>
            <td align="center">${ c.createdAt }</td>
        </tr>
    </c:forEach>
	</table>

<div>
	<form action="routecomment.do">
	<input type="hidden" name="postId" value="${ route.routeBoardId }">
	<input type="hidden" name="userId" value="${ sessionScope.loginUser.memId }">
	<textarea name="content" rows="3" cols="30"></textarea>
	<input type="submit"  value="등록">
	</form>
</div>
</div>

<br>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>