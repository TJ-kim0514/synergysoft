<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>BonVoyage - 새 블로그 등록</title>

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Toast UI Editor CSS -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f8f9fa;
    }
    h1 {
      margin: 30px 0;
    }
    .container {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    .form-control {
      border-radius: 8px;
    }
    .btn-custom {
      background-color: #28a745;
      border-color: #28a745;
      color: white;
    }
    .btn-custom:hover {
      background-color: #218838;
      border-color: #1e7e34;
    }
    /* 새롭게 추가된 내용 박스 */
    #content-box {
      border: 2px solid #dee2e6;
      border-radius: 8px;
      padding: 15px;
      background-color: #f8f9fa;
    }
    .editor-title {
      font-weight: bold;
      margin-bottom: 10px;
    }
    #previewContainer {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }
    #previewContainer img {
      width: 150px;
      height: 150px;
      border: 1px solid navy;
      cursor: pointer;
    }
    #photofile {
      display: none;
    }
  </style>
</head>

<body>

  <!-- Navbar -->
  <c:import url="/WEB-INF/views/common/menubar.jsp" />

  <div class="container mt-5">
    <h1 class="text-center">새 블로그 등록</h1>

    <form action="ginsert.do" method="post" enctype="multipart/form-data">
      <div class="mb-3">
        <label for="guideTitle" class="form-label">제목</label>
        <input type="text" name="guideTitle" id="guideTitle" class="form-control" placeholder="블로그 제목을 입력하세요">
      </div>

      <div class="mb-3">
        <label for="guideWriter" class="form-label">작성자</label>
        <input type="text" name="guideWriter" id="guideWriter" class="form-control" readonly value="${sessionScope.loginUser.userId}">
      </div>

      <div class="mb-3">
        <label for="guideLocation" class="form-label">지역</label>
        <input type="text" name="guideLocation" id="guideLocation" class="form-control" placeholder="지역을 입력하세요">
      </div>

      <!-- 새롭게 추가된 내용 박스 -->
      <div id="content-box" class="mb-3">
        <div class="editor-title">내용</div>
        <textarea name="guideContent" id="guideContent" class="form-control" rows="8" placeholder="블로그 내용을 입력하세요" style="border: none; background-color: transparent;"></textarea>
      </div>

    <div class="mb-3">
    <label for="photofile" class="form-label">사진 첨부</label>
    <c:forEach var="i" begin="1" end="5">
        <input type="file" id="photofile${i}" name="gmfiles" class="form-control mb-2">
    </c:forEach>
</div>


      <!-- 미리보기 이미지들이 추가되는 컨테이너 -->
      <div id="previewContainer"></div>

      <!-- Toast UI Editor -->
      <div id="editor" class="mb-3"></div>

      <div class="d-grid gap-2 d-md-flex justify-content-md-end">
        <input type="submit" value="등록하기" class="btn btn-custom me-md-2">
        <input type="reset" value="작성취소" class="btn btn-secondary">
        <input type="button" value="목록" class="btn btn-outline-secondary" onclick="javascript:history.go(-1); return false;">
      </div>
    </form>
  </div>

  <!-- Bootstrap 5 JS and dependencies -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

  <!-- Toast UI Editor JS -->
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

  <script type="text/javascript">
    let currentImgIndex = -1; // 현재 클릭된 이미지 인덱스 저장 변수

    // Toast UI Editor 설정
    const editor = new toastui.Editor({
      el: document.querySelector('#editor'),
      height: '400px',
      initialEditType: 'markdown',
      previewStyle: 'vertical'
    });

    // 파일 선택 시 동적으로 이미지를 미리보기 컨테이너에 추가
    document.getElementById('photofile').addEventListener('change', function(event) {
      const files = event.target.files;
      const previewContainer = document.getElementById('previewContainer');

      if (currentImgIndex === -1) {
        // 각 파일을 순회하면서 이미지 미리보기를 생성
        for (let i = 0; i < files.length; i++) {
          const file = files[i];
          const reader = new FileReader();

          reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.dataset.index = i; // 인덱스를 데이터 속성으로 저장
            img.addEventListener('click', function() {
              currentImgIndex = img.dataset.index; // 클릭한 이미지의 인덱스를 저장
              document.getElementById('photofile').click(); // 파일 선택창을 다시 열어줌
            });
            previewContainer.appendChild(img); // 이미지를 미리보기 컨테이너에 추가
          };

          reader.readAsDataURL(file); // 파일을 읽어서 이미지 URL로 변환
        }
      } else {
        // 클릭한 이미지의 인덱스에 해당하는 파일을 새로운 파일로 교체
        const reader = new FileReader();
        reader.onload = function(e) {
          const img = previewContainer.querySelector(`img[data-index="${currentImgIndex}"]`);
          img.src = e.target.result; // 이미지를 새 파일로 변경
        };
        reader.readAsDataURL(files[0]); // 선택한 첫 번째 파일로 교체
        currentImgIndex = -1; // 다시 초기화
      }
    });
  </script>

</body>
</html>
