<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Blog Post Edit</title>
    <!-- Bootstrap CSS 라이브러리 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            max-width: 800px;
            margin-top: 50px;
        }
        .post-header {
            background-color: #343a40;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 5px;
        }
        .post-form {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group label {
            font-weight: bold;
            color: #343a40;
        }
        .form-control {
            margin-bottom: 20px;
        }
        .btn-primary, .btn-secondary {
            width: 100px;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        footer {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
        }
        .image-preview {
            display: inline-block;
            margin-bottom: 20px;
            margin-right: 10px;
            max-width: 150px;
            height: auto;
        }
        .form-control-file {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <!-- 컨테이너 시작 -->
    <div class="container">
        <!-- 게시글 수정 제목 -->
        <div class="post-header">
            <h2>${ guide.guidepostId } 번 게시글 수정</h2>
        </div>

        <!-- 게시글 수정 폼 -->
        <form action="gupdate.do" method="post" class="post-form" enctype="multipart/form-data">
            <!-- 게시글 ID를 숨긴 필드로 넘김 -->
            <input type="hidden" name="guidepostId" value="${ guide.guidepostId }">

            <!-- 제목 입력 필드 -->
            <div class="form-group">
                <label for="guideTitle">제목</label>
                <input type="text" class="form-control" id="guideTitle" name="guideTitle" value="${ guide.guideTitle }" placeholder="제목을 입력하세요">
            </div>

            <!-- 작성자 입력 필드 (수정 불가, readonly) -->
            <div class="form-group">
                <label for="guideUserId">작성자</label>
                <input type="text" class="form-control" id="guideUserId" name="guideUserId" readonly value="${ sessionScope.loginUser.userId }">
            </div>

            <!-- 내용 입력 필드 -->
            <div class="form-group">
                <label for="guideContent">내용</label>
                <textarea class="form-control" id="guideContent" name="guideContent" rows="5" placeholder="내용을 입력하세요">${ guide.guideContent }</textarea>
            </div>

           <!-- 이미지 파일 미리보기 및 수정 필드 -->
      
<div class="form-group">
    <label for="guideImages">이미지 수정</label>
    <div id="imagePreview">
        <!-- 기존 이미지 1 미리보기 -->
        <c:if test="${ !empty guide.rFile1}">
            <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile1}" alt="이미지1" class="image-preview" id="currentImage1">
            <input type="file" class="form-control-file" name="gmfiles" id="imageUpload1" accept="image/*" onchange="previewImage(event, 1)">
            <label><input type="checkbox" name="deleteFlag1" value="yes"> 이미지 1 삭제</label><br>
        </c:if>
        <c:if test="${empty guide.rFile1}">
            첨부 파일 없음<br>
            추가 : <input type="file" class="form-control-file" name="gmfiles" id="imageUpload1" accept="image/*" onchange="previewImage(event, 1)">
            <img id="preview1" class="image-preview" style="display: none;">
        </c:if>

        <!-- 기존 이미지 2 미리보기 -->
        <c:if test="${ !empty guide.rFile2}">
            <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile2}" alt="이미지2" class="image-preview" id="currentImage2">
            <input type="file" class="form-control-file" name="gmfiles" id="imageUpload2" accept="image/*" onchange="previewImage(event, 2)">
            <label><input type="checkbox" name="deleteFlag2" value="yes"> 이미지 2 삭제</label><br>
        </c:if>
        <c:if test="${empty guide.rFile2}">
            첨부 파일 없음<br>
            추가 : <input type="file" class="form-control-file" name="gmfiles" id="imageUpload2" accept="image/*" onchange="previewImage(event, 2)">
            <img id="preview2" class="image-preview" style="display: none;">
        </c:if>

        <!-- 기존 이미지 3 미리보기 -->
        <c:if test="${ !empty guide.rFile3}">
            <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile3}" alt="이미지3" class="image-preview" id="currentImage3">
            <input type="file" class="form-control-file" name="gmfiles" id="imageUpload3" accept="image/*" onchange="previewImage(event, 3)">
            <label><input type="checkbox" name="deleteFlag3" value="yes"> 이미지 3 삭제</label><br>
        </c:if>
        <c:if test="${empty guide.rFile3}">
            첨부 파일 없음<br>
            추가 : <input type="file" class="form-control-file" name="gmfiles" id="imageUpload3" accept="image/*" onchange="previewImage(event, 3)">
            <img id="preview3" class="image-preview" style="display: none;">
        </c:if>

        <!-- 기존 이미지 4 미리보기 -->
        <c:if test="${ !empty guide.rFile4}">
            <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile4}" alt="이미지4" class="image-preview" id="currentImage4">
            <input type="file" class="form-control-file" name="gmfiles" id="imageUpload4" accept="image/*" onchange="previewImage(event, 4)">
            <label><input type="checkbox" name="deleteFlag4" value="yes"> 이미지 4 삭제</label><br>
        </c:if>
        <c:if test="${empty guide.rFile4}">
            첨부 파일 없음<br>
            추가 : <input type="file" class="form-control-file" name="gmfiles" id="imageUpload4" accept="image/*" onchange="previewImage(event, 4)">
            <img id="preview4" class="image-preview" style="display: none;">
        </c:if>

        <!-- 기존 이미지 5 미리보기 -->
        <c:if test="${ !empty guide.rFile5}">
            <img src="${pageContext.request.contextPath}/resources/guide_upfiles/${guide.rFile5}" alt="이미지5" class="image-preview" id="currentImage5">
            <input type="file" class="form-control-file" name="gmfiles" id="imageUpload5" accept="image/*" onchange="previewImage(event, 5)">
            <label><input type="checkbox" name="deleteFlag5" value="yes"> 이미지 5 삭제</label><br>
        </c:if>
        <c:if test="${empty guide.rFile5}">
            첨부 파일 없음<br>
            추가 : <input type="file" class="form-control-file" name="gmfiles" id="imageUpload5" accept="image/*" onchange="previewImage(event, 5)">
            <img id="currentImage5" class="image-preview" style="display: none;">
        </c:if>
    </div>
</div>




<!-- 이미지 미리보기 스크립트 -->
<script>
    function previewImage(event, imageNumber) {
        const reader = new FileReader();
        const imageElement = document.getElementById('currentImage' + imageNumber);
        
        reader.onload = function() {
            imageElement.src = reader.result;
        };
        
        reader.readAsDataURL(event.target.files[0]);
    }
</script>


            <!-- 폼 하단의 버튼들 -->
            <div class="d-flex justify-content-between">
                <div>
                    <!-- 수정하기 버튼 -->
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <!-- 취소 버튼 (작성 내용 초기화) -->
                    <input type="reset" class="btn btn-secondary" value="취소">
                </div>
                <div>
                    <!-- 목록으로 이동 버튼 -->
                    <a href="${pageContext.servletContext.contextPath}/sagBlog.do" class="btn btn-back">목록</a>
                    <!-- 이전 페이지로 이동 버튼 -->
                    <button class="btn btn-back" onclick="javascript:history.go(-1); return false;">이전 페이지</button>
                </div>
            </div>
        </form>

        <!-- 하단의 푸터 영역 -->
        <footer>
            <p>&copy; 2024 Bon voyage</p>
        </footer>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


