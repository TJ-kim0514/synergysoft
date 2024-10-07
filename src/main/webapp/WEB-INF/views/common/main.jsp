<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">

	//공지사항 top10
	$(function(){
		$.ajax({
			url:'stnotice.do',
			type:'post',
			dataType:'json',
			success:function(data){
				console.log('success : '+data);
				
				var str = JSON.stringify(data);
				
				var json = JSON.parse(str);
				
				values = '';
				for(var i in json.nlist){
					
					values += '<tr><td>' + decodeURIComponent(json.nlist[i].noticeId).substring(7)
					+'</td><td align="left">&nbsp;<a class="truncate" href="msnotice.do?noticeId='+ json.nlist[i].noticeId +'">'
					+ decodeURIComponent(json.nlist[i].title).replace(/\+/gi,' ')
					+'</a></td><td class="truncate">'+json.nlist[i].createAt + '</td></tr>';
				}
				
				$('#topnotice').html($('#topnotice').html()+values);
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log('error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
			}
		})
	});
	
/* 	// QnA top10
	$(function(){
		$.ajax({
			url:'stqna.do',
			type:'post',
			dataType:'json',
			success:function(data){
				console.log('success : '+data);
				
				var str = JSON.stringify(data);
				
				var json = JSON.parse(str);
				
				values = '';
				for(var i in json.qlist){
					
					values += '<tr><td>' + decodeURIComponent(json.qlist[i].qnaId).substring(4)
					+'</td><td align="left">&nbsp;<a href="msqna.do?qnaId='+ json.qlist[i].qnaId +'", style="color: black; text-decoration: none;">'
					+ decodeURIComponent(json.qlist[i].title).replace(/\+/gi,' ')
					+'</a></td><td>'+json.qlist[i].qCreatedAt + '</td></tr>';
				}
				
				$('#topqna').html($('#topqna').html()+values);
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log('error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
			}
		})
	}); */
	
</script>
<style>
  body {
    background-color: #f8f9fa;
  }
  table {
    background-color: #ffffff;
  }
  th {
    background-color: #4ba483;
    color: white;
  }
  td a {
    color: black;
    text-decoration: none;
  }

  .truncate {
  white-space: nowrap;        /* 한 줄로 표시 */
  overflow: hidden;           /* 넘치는 텍스트는 숨김 */
  text-overflow: ellipsis;    /* 넘치는 텍스트에 '...' 표시 */
  width: 100%;                /* 부모 요소의 크기에 맞춤 */
  }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	
<br>
<div class="container text-center">
  <div class="row">
    <div class="col-7">
		<h1> 빈도지도 만들기</h1>
    </div>
    <div class="col-3">
      <!-- <div style="display: flex; justify-content: space-between; align-items: center;">
		    <div>
		        <h4> &nbsp; Q&A</h4>
		    </div>
		    <div>
		        <h6></h6><a href="saqna.do" style="text-decoration:none; color:black;">더보기</a></h6>
		    </div>
		</div>
      	<table id="topqna">
		<tr align="center">
			<th width="80px" >No</th>
			<th width="500px">질문</th>
			<th width="200px">등록일</th>
		</tr>
	</table> -->
		<div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		    <div>
		        <h4> - 공지사항</h4>
		    </div>
		    <div>
		        <a href="sanotice.do" style="text-decoration:none; color:black;">더보기</a>
		    </div>
		</div>
      	<table id="topnotice">
		<tr>
			<th width="80px" >No</th>
			<th width="500px">제목</th>
			<th width="200px">등록일</th>
		</tr>
	</table>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <h1>인기 경로추천 넣기</h1>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <h1>인기 지역소담이 넣기</h1>
    </div>
  </div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>