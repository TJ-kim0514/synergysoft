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
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

</head>
<body>
<nav>
	<c:import url="/WEB-INF/views/common/menubar.jsp"/>
</nav>

   <script>
/*
            var map;
            var startPointMarker = null;
            var endPointMarker = null;
            var wayPointMarker = null;
            var pointObj = {
                startPoint: { lat: null, lng: null },
                endPoint: { lat: null, lng: null },
                wayPoint: { lat: null, lng: null }
            };


            let waypoints = [];  // 경유지 좌표를 저장할 배열

            // 경유지를 설정하는 함수
            async function setWaypoint() {
                waypoints = []; // 새로 시작할 때 경유지 배열 초기화
                for (let i = 1; i <= searchIndex; i++) {
                    const address = document.getElementById(`addressInput${i}`).value;
                    if (!address) {
                        alert('목적지 주소를 입력하세요.');
                        return;
                    }

                    // 주소를 좌표로 변환하는 작업을 비동기 처리
                    await addWaypoint(address, i);
                }
                console.log("모든 경유지: ", waypoints);
                // 여기서 waypoints 배열을 사용해 다중 경유지 경로 요청을 할 수 있습니다.
            }

            // 경유지 좌표를 추가하는 비동기 함수
            function addWaypoint(address, index) {
                return new Promise((resolve, reject) => {
                    const geocoder = new kakao.maps.services.Geocoder();

                    geocoder.addressSearch(address, function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            const lat = result[0].y;
                            const lng = result[0].x;

                            // 경유지 마커 표시
                            const wayPointMarker = new kakao.maps.Marker({
                                position: new kakao.maps.LatLng(lat, lng)
                            });
                            wayPointMarker.setMap(map);

                            // 경유지 좌표를 waypoints 배열에 추가
                            waypoints.push({
                                viaPoint: { location: `${lng},${lat}` }
                            });
                            console.log(`경유지 ${index} : ${lng}, ${lat}`);

                            resolve();  // 비동기 작업 완료
                        } else {
                            alert('정확한 주소를 입력해주세요.');
                            reject();  // 비동기 작업 실패
                        }
                    });
                });
            }

            // 경로 조회 (다중 경유지 기능)
            async function getCarDirection() {
                const REST_API_KEY = '5490ba4a232feea77f50bc7e61096d1d'; // 실제 API 키로 교체
                const url = 'https://apis-navi.kakaomobility.com/v1/waypoints/directions';

                if (!pointObj.startPoint.lat || !pointObj.endPoint.lat) {
                    alert('출발지와 목적지를 모두 설정해주세요.');
                    return;
                }

                const origin = `${pointObj.startPoint.lng},${pointObj.startPoint.lat}`;
                const destination = `${pointObj.endPoint.lng},${pointObj.endPoint.lat}`;

                const headers = {
                    Authorization: `KakaoAK ${REST_API_KEY}`,
                    'Content-Type': "application/json"
                };

                // 경로 요청에 필요한 본문 (origin, destination, waypoints)
                const body = JSON.stringify({
                    origin: origin,
                    destination: destination,
                    waypoints: waypoints
                });

                try {
                    const response = await fetch(url, {
                        method: 'POST',
                        headers: headers,
                        body: body
                    });

                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }

                    const data = await response.json();
                    document.getElementById('result').textContent = JSON.stringify(data, null, 2);

                    // 경로를 지도에 그리기
                    drawRouteOnMap(data);
                } catch (error) {
                    console.error('Error:', error);
                    document.getElementById('result').textContent = 'Error: ' + error;
                }
            }

            let polyline = null;  // Polyline을 저장할 전역 변수

            // 경로 그리기 함수
            function drawRouteOnMap(data) {
                // 기존에 그려진 경로가 있으면 삭제
                if (polyline) {
                    polyline.setMap(null);  // 기존 경로를 지도에서 제거
                }

                const linePath = [];
                data.routes[0].sections[0].roads.forEach(road => {
                    road.vertexes.forEach((vertex, index) => {
                        if (index % 2 === 0) {
                            linePath.push(new kakao.maps.LatLng(road.vertexes[index + 1], road.vertexes[index]));
                        }
                    });
                });

                // 새로운 Polyline 객체 생성
                polyline = new kakao.maps.Polyline({
                    path: linePath,
                    strokeWeight: 5,
                    strokeColor: '#007aff',  // 선 색상
                    strokeOpacity: 0.7,
                    strokeStyle: 'solid'
                });

                // 새롭게 생성된 Polyline을 지도에 표시
                polyline.setMap(map);

                // 지도 범위를 경로에 맞게 설정
                map.setBounds(new kakao.maps.LatLngBounds(linePath[0], linePath[linePath.length - 1]));
            } */
        </script>



<!-- 검색창 추가 버튼 -->
<!-- <div class="container">
    <button class="btn btn-primary" onclick="addSearchInput(); return false;">추가</button>
</div> -->



<c:import url="/WEB-INF/views/bmap/bmapRoute.html" charEncoding="utf-8"></c:import>


<footer>
	<c:import url="/WEB-INF/views/common/footer.jsp"/>
</footer>
</body>
</html>
