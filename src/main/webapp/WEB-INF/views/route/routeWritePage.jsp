<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
    <style type="text/css">
        .location-item {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
            position: relative;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .location-inputs {
            display: flex;
            gap: 10px;
        }
        .location-description {
            width: 400px;
            height: 100px;
            margin-top: 10px;
        }
        .delete-button {
            width: 50px;
            height: 30px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        div#locationContainer {
            display: flex;
            width: 500px;
        }
        div#locationRouteContent {
            display: flex;
            width: 400px;
        }
/*         #locationInputArea {
            display: flex;
            justify-content: center;
            gap: 10px;
        } */
		.submit-button-container {
		    display: flex;
		    justify-content: wrap; /* 중앙 정렬 */
		    align-items: center;     /* 수직 중앙 정렬 */
		    flex-direction: row;     /* 가로 방향으로 */
		    height: auto;            /* 높이를 자동으로 설정 */
		    padding-top: 20px;       /* 버튼 위에 여백 추가 */
		}
    </style>
</head>
<body>

    <h2 align="center">경로 추천 작성</h2>
	<button type="button" onclick="addLocationFields()" id="addbutton">추가</button>
	<br> <br>
	<hr>
	<br>
    <form action="submitLocations.jsp" method="post" id="locationInputArea">
        <div id="locationContainer">
            <!-- 필드가 추가될 부분 -->
        </div>
        <br>
        <div id="locationRouteContent">
            <fieldset>
                <legend>내용</legend>
                <textarea rows="100" cols="100" name="routeContent" id="routeContent"></textarea>
            </fieldset>
        </div>
        <!-- 등록 버튼을 감싸는 div 추가 -->
		<div class="submit-button-container">
		    <input type="submit" value="등록" id="insertbutton">
		</div>
    </form>

    <script type="text/javascript">
        var locationCounter = 0;

        function addLocationFields() {
            var container = document.getElementById("locationContainer");

            var newDiv = document.createElement("div");
            newDiv.classList.add("location-item");
            newDiv.setAttribute("id", "location-item-" + locationCounter);

            var inputsDiv = document.createElement("div");
            inputsDiv.classList.add("location-inputs");

            // 장소검색칸 input 생성
            var searchInput = document.createElement("input");
            searchInput.setAttribute("type", "text");
            searchInput.setAttribute("name", "locationAddress[]");
            searchInput.setAttribute("placeholder", "장소 주소");
            searchInput.setAttribute("id", "locationSearch_" + locationCounter);

            // 장소이름 input 생성
            var nameInput = document.createElement("input");
            nameInput.setAttribute("type", "text");
            nameInput.setAttribute("name", "locationName[]");
            nameInput.setAttribute("placeholder", "장소 이름");
            nameInput.setAttribute("id", "locationName_" + locationCounter);

            // 교통수단 드롭다운 생성
            var transportSelect = document.createElement("select");
            transportSelect.setAttribute("name", "transportMode[]");
            transportSelect.setAttribute("id", "transportMode_" + locationCounter);

            var options = ["버스", "지하철", "택시", "자전거", "도보"];
            for (var i = 0; i < options.length; i++) {
                var option = document.createElement("option");
                option.value = options[i];
                option.text = options[i];
                transportSelect.appendChild(option);
            }

            // 장소설명 textarea 생성
            var descInput = document.createElement("textarea");
            descInput.setAttribute("name", "locationDescription[]");
            descInput.setAttribute("placeholder", "장소 설명");
            descInput.setAttribute("id", "locationDescription_" + locationCounter);
            descInput.classList.add("location-description");

            // 삭제 버튼 생성
            var deleteButton = document.createElement("button");
            deleteButton.setAttribute("type", "button");
            deleteButton.classList.add("delete-button");
            deleteButton.innerHTML = "삭제";
            deleteButton.setAttribute("onclick", "removeLocationFields('location-item-" + locationCounter + "')");

            // inputsDiv에 장소검색, 장소이름, 교통수단 추가
            inputsDiv.appendChild(searchInput);
            inputsDiv.appendChild(nameInput);
            inputsDiv.appendChild(transportSelect);

            // newDiv에 inputsDiv와 장소설명, 삭제 버튼 추가
            newDiv.appendChild(inputsDiv);
            newDiv.appendChild(descInput);
            newDiv.appendChild(deleteButton);

            container.appendChild(newDiv);

            locationCounter++;
        }

        function removeLocationFields(itemId) {
            var item = document.getElementById(itemId);
            if (item) {
                item.remove();
            }
        }
    </script>
</body>
</html>