<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
     <style>
        .location-item {
            display: flex;
            flex-direction: column; /* 필드가 위에서 아래로 쌓이도록 설정 */
            margin-bottom: 20px; /* 각 장소 필드 그룹 간격 */
        }
        .location-inputs {
            display: flex;
            gap: 10px; /* 장소검색과 장소이름 사이 간격 */
        }
        .location-description {
            width: 400px;
            height: 100px;
            margin-top: 10px; /* 설명칸과 위의 필드 사이 여백 */
        }
    </style>
    <script type="text/javascript">
        // 입력 필드 고유 id와 name을 위한 카운터 변수
        var locationCounter = 0;

        function addLocationFields() {
            // 장소 필드가 추가될 div 요소 가져오기
            var container = document.getElementById("locationContainer");

            // 새로운 div 생성
            var newDiv = document.createElement("div");
            newDiv.classList.add("location-item");

            // 새로운 div 안에 장소검색칸과 장소이름칸을 위한 div 생성
            var inputsDiv = document.createElement("div");
            inputsDiv.classList.add("location-inputs");

            // 장소검색칸 input 생성
            var searchInput = document.createElement("input");
            searchInput.setAttribute("type", "search");
            searchInput.setAttribute("name", "locationSearch[]");
            searchInput.setAttribute("placeholder", "장소 검색");
            searchInput.setAttribute("id", "locationSearch_" + locationCounter);

            // 장소이름 input 생성
            var nameInput = document.createElement("input");
            nameInput.setAttribute("type", "text");
            nameInput.setAttribute("name", "locationName[]");
            nameInput.setAttribute("placeholder", "장소 이름");
            nameInput.setAttribute("id", "locationName_" + locationCounter);

            // 장소설명 textarea 생성
            var descInput = document.createElement("textarea");
            descInput.setAttribute("name", "locationDescription[]");
            descInput.setAttribute("placeholder", "장소 설명");
            descInput.setAttribute("id", "locationDescription_" + locationCounter);
            descInput.classList.add("location-description"); // CSS 클래스 추가

            // inputsDiv에 장소검색과 장소이름 추가
            inputsDiv.appendChild(searchInput);
            inputsDiv.appendChild(nameInput);

            // newDiv에 inputsDiv와 장소설명 추가
            newDiv.appendChild(inputsDiv);
            newDiv.appendChild(descInput);

            // 새로운 필드 그룹을 container에 추가
            container.appendChild(newDiv);

            // 카운터 증가
            locationCounter++;
        }
    </script>
</head>
<body>

    <h2>장소 추가 페이지</h2>
    
    <button type="button" onclick="addLocationFields()">추가</button> <br>

    <form action="submitLocations.jsp" method="post"> <br>
        <div id="locationContainer">
            <!-- 필드가 추가될 부분 -->
        </div>

        <br>
        <input type="submit" value="제출">
    </form>

</body>
</html>