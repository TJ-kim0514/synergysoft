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
<%-- 지도 api용 스크립트 --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c21cf4a0f3f4a8aa848524ff9fe27db"></script>
<%-- 지도 실제구현 --%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/mainMarkerMap.js"></script>
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
	
	
	//가이드게시판 인기 게시글 3개 (top-N) 전송받아서 출력 처리
$.ajax({
    url: 'gtop3.do',  // 서버의 데이터 요청 URL
    type: 'post',
    dataType: 'json',
    success: function(data) {
        console.log(data);  // 응답 데이터 확인
        if (data.glist && data.glist.length > 0) {
            // 첫 번째 슬라이드 이미지와 링크 설정
            $('#carouselExampleIndicators .carousel-item:nth-child(1) a').attr('href', '${pageContext.servletContext.contextPath}/gdetail.do?guidepostId=' + data.glist[0].guidepostId);
            $('#carouselExampleIndicators .carousel-item:nth-child(1) img').attr('src', '${pageContext.servletContext.contextPath}/resources/guide_upfiles/' + data.glist[0].rFile1);
            $('.carousel-item:nth-child(1) .carousel-caption h5').text(decodeURIComponent(data.glist[0].gtitle).replace(/\+/g, ' '));
            $('.carousel-item:nth-child(1) .carousel-caption p').text(decodeURIComponent(data.glist[0].glocation).replace(/\+/g, ' '));
            console.log('첫 번째 포스트 제목:', data.glist[0].gtitle);  // 첫 번째 포스트의 제목 확인
            console.log('첫 번째 포스트 지역:', data.glist[0].location);  

            // 두 번째 슬라이드 이미지와 링크 설정
            $('#carouselExampleIndicators .carousel-item:nth-child(2) a').attr('href', '${pageContext.servletContext.contextPath}/gdetail.do?guidepostId=' + data.glist[1].guidepostId);
            $('#carouselExampleIndicators .carousel-item:nth-child(2) img').attr('src', '${pageContext.servletContext.contextPath}/resources/guide_upfiles/' + data.glist[1].rFile1);
            $('.carousel-item:nth-child(2) .carousel-caption h5').text(decodeURIComponent(data.glist[1].gtitle).replace(/\+/g, ' '));
            $('.carousel-item:nth-child(2) .carousel-caption p').text(decodeURIComponent(data.glist[1].glocation).replace(/\+/g, ' '));

            // 세 번째 슬라이드 이미지와 링크 설정
            $('#carouselExampleIndicators .carousel-item:nth-child(3) a').attr('href', '${pageContext.servletContext.contextPath}/gdetail.do?guidepostId=' + data.glist[2].guidepostId);
            $('#carouselExampleIndicators .carousel-item:nth-child(3) img').attr('src', '${pageContext.servletContext.contextPath}/resources/guide_upfiles/' + data.glist[2].rFile1);
            $('.carousel-item:nth-child(3) .carousel-caption h5').text(decodeURIComponent(data.glist[2].gtitle).replace(/\+/g, ' '));
            $('.carousel-item:nth-child(3) .carousel-caption p').text(decodeURIComponent(data.glist[2].glocation).replace(/\+/g, ' '));
        }
    },
    error: function(jqXHR, textStatus, errorThrown) {
        console.error('Error loading top blogs: ' + textStatus + ', ' + errorThrown);
    }
});

	
	
	
	
</script>
<style>

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
    <div class="col-8" style="height: 700px;" id="map" style="border: 1px solid black;">
    </div>
    <div class="col-4">
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
		    <div class="h4">
		        &nbsp;공지사항
		    </div>
		    <div>
		        <a href="sanotice.do" style="text-decoration:none; color:black;">더보기</a>
		    </div>
		</div>
      	<table class="table table-sm" id="topnotice">
		<tr class="table-success">
			<th>No</th>
			<th>제목</th>
			<th>등록일</th>
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
  
<style>
  /* 캐러셀 컨테이너의 전체 크기를 조정 */
  .carousel {
    width: 60%;     /* 전체 너비의 60%로 설정 */
    margin: 0 auto; /* 중앙에 정렬 */
  }

  /* 슬라이드 이미지 크기 조정 */
  .carousel-inner img {
    width: 100%;    /* 슬라이드 이미지의 너비를 부모 요소의 너비에 맞춤 */
    height: 300px;  /* 이미지 높이를 300px로 고정 */
    object-fit: cover; /* 이미지 비율을 유지하면서 넘치는 부분을 잘라냄 */
  }

  /* 슬라이드 안에 제목과 지역 정보를 표시할 스타일 */
  .carousel-caption {
    position: absolute;
    bottom: 20px;
    left: 20px;
    color: white;
    background-color: rgba(0, 0, 0, 0.5); /* 배경을 반투명하게 */
    padding: 10px;
    border-radius: 5px;
  }
</style>

<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  
  <div class="carousel-inner">
    <!-- 첫 번째 슬라이드 -->
    <div class="carousel-item active">
      <a href="#">
        <img src="https://via.placeholder.com/300x150" class="d-block w-100" alt="블로그 이미지">
      </a>
      <div class="carousel-caption">
        <h5>제목</h5>
        <p>지역</p>
      </div>
    </div>

    <!-- 두 번째 슬라이드 -->
    <div class="carousel-item">
      <a href="#">
        <img src="https://via.placeholder.com/300x150" class="d-block w-100" alt="블로그 이미지">
      </a>
      <div class="carousel-caption">
        <h5>제목</h5>
        <p>지역</p>
      </div>
    </div>

    <!-- 세 번째 슬라이드 -->
    <div class="carousel-item">
      <a href="#">
        <img src="https://via.placeholder.com/300x150" class="d-block w-100" alt="블로그 이미지">
      </a>
      <div class="carousel-caption">
        <h5>제목</h5>
        <p>지역</p>
      </div>
    </div>
  </div>
  
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>



    
    </div>
  </div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>