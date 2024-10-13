<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bon voyage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cc86f31dc51c7974b7eaa99b903eea0&libraries=services,drawing,clusterer"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/bmap.js"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    <style type="text/css">
        /* 검색창 스타일 */
        #searchInput {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        /* 드롭다운 리스트 스타일 */
        #suggestions {
            border: 1px solid #ccc;
            border-radius: 4px;
            max-height: 200px;
            overflow-y: auto;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            z-index: 1000;
            display: none;
        }
        
         #suggestions.show {
            display: block; /* 검색 결과가 있을 때만 드롭다운을 표시 */
        }

        #suggestions li {
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s ease-in-out;
        }

        #suggestions li:last-child {
            border-bottom: none;
        }

        #suggestions li:hover {
            background-color: #f2f2f2;
        }

        /* 드롭다운 리스트의 스크롤바 스타일 */
        #suggestions::-webkit-scrollbar {
            width: 6px;
        }

        #suggestions::-webkit-scrollbar-thumb {
            background-color: #ccc;
            border-radius: 3px;
        }
    </style>

<script type="text/javascript">
var map;  // 전역 변수로 선언

window.onload = function() {
    var mapContainer = document.getElementById('map'); 
    if (mapContainer) {
        var mapOption = { 
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울시청 좌표 
            level: 3 
        };
        map = new kakao.maps.Map(mapContainer, mapOption); 
    } else {
        console.error("Map container not found");
    }
    
    // 출발지와 목적지 설정
    var startPosition = new kakao.maps.LatLng(37.5665, 126.9780); // 서울시청
    var endPosition = new kakao.maps.LatLng(37.5149, 127.0364);   // 강남역

    // 지도에 마커 표시
    var startMarker = new kakao.maps.Marker({
        position: startPosition,
    });

    var endMarker = new kakao.maps.Marker({
        position: endPosition,
    });

    startMarker.setMap(map);
    endMarker.setMap(map);

    // 경로 탐색 API 호출
    async function getRoute() {
        const apiKey = '0a6131ba188f75547a53032b153a4c12';  // 발급받은 REST API 키
        const originLng = startPosition.getLng();
        const originLat = startPosition.getLat();
        const destinationLng = endPosition.getLng();
        const destinationLat = endPosition.getLat();

        // 좌표값 로그로 확인
        console.log("출발지 경도:", originLng, "출발지 위도:", originLat);
        console.log("목적지 경도:", destinationLng, "목적지 위도:", destinationLat);

        // 좌표값이 제대로 설정되었는지 확인
        if (!originLng || !originLat || !destinationLng || !destinationLat) {
            console.error("출발지 또는 목적지 좌표가 유효하지 않습니다.");
            return;
        }

        const url = `https://apis-navi.kakaomobility.com/v1/directions?origin=startPosition&destination=endPosition`;
		console.log("url : ", url)
        try {
            const response = await fetch(url, {
                method: 'GET',
                headers: {
                    Authorization: `KakaoAK ${apiKey}`,  // 템플릿 리터럴 수정
                    'Content-Type': 'application/json'
                },
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log("API 응답 데이터:", data);
            return data;

        } catch (error) {
            console.error("경로 탐색 중 에러 발생:", error);
            return null;
        }
    }

    // 경로를 지도에 표시
    getRoute().then(data => {
        if (data && data.routes && data.routes.length > 0) {
            const path = data.routes[0].sections[0].roads.map(road => {
                return new kakao.maps.LatLng(road.y, road.x);
            });

            const polyline = new kakao.maps.Polyline({
                path: path,
                strokeWeight: 5,
                strokeColor: '#FF0000',
                strokeOpacity: 1.0,
                strokeStyle: 'solid'
            });

            polyline.setMap(map);
        } else {
            console.error("경로 탐색 결과가 없습니다.");
        }
    });
};




</script>
</head>
<body>
<nav>
	<c:import url="/WEB-INF/views/common/menubar.jsp"/>
</nav>

	<div id="map" class="container text-center" style="width: 100%; height: 700px;"></div>

	<div class="container">
    <input type="text" id="searchInput" placeholder="장소나 주소를 입력하세요" onkeyup="handleKeyPress(event)" autocomplete="off" />
    <input type="text" id="address" />
    </div>
    
    <div class="container">
    <ul id="suggestions"></ul>
	</div>


<footer>
	<c:import url="/WEB-INF/views/common/footer.jsp"/>
</footer>
</body>
</html>