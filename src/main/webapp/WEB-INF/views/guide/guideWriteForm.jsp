<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bon Voyage - 새 블로그 등록</title>

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
    const editor = new toastui.Editor({
      el: document.querySelector('#editor'),
      height: '400px',
      initialEditType: 'markdown',
      previewStyle: 'vertical'
    });
  </script>

</body>
</html>
