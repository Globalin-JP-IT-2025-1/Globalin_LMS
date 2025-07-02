<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 도서 추가 폼 -->
<form action="/admin/books" method="post" class="container mt-4 p-4 border rounded bg-light shadow-sm">

    <!-- CSRF 토큰 -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    <h4 class="mb-4">도서 등록</h4>

    <div class="mb-3">
        <label for="category" class="form-label">KDC분류</label>
        <input type="text" class="form-control" id="category" name="category" maxlength="50" placeholder="예: 컴퓨터, 문학 등">
    </div>

    <div class="mb-3">
        <label for="title" class="form-label">제목</label>
        <input type="text" class="form-control" id="title" name="title" maxlength="200" placeholder="도서 제목을 입력하세요">
    </div>

    <div class="mb-3">
        <label for="author" class="form-label">저자</label>
        <input type="text" class="form-control" id="author" name="author" maxlength="100" placeholder="저자 이름">
    </div>

    <div class="mb-3">
        <label for="publisher" class="form-label">출판사</label>
        <input type="text" class="form-control" id="publisher" name="publisher" maxlength="100" placeholder="출판사 이름">
    </div>

    <div class="mb-3">
        <label for="isbn" class="form-label">ISBN</label>
        <div class="input-group">
            <input type="text" class="form-control" id="isbn" name="isbn" maxlength="50" placeholder="ISBN 번호">
            <button type="button" class="btn btn-outline-secondary" onclick="openIsbnPopup()">ISBN으로 도서 가져오기</button>
        </div>
    </div>

    <div class="mb-3">
        <label for="imageLink" class="form-label">책 이미지 링크</label>
        <input type="text" class="form-control" id="imageLink" name="imageLink" maxlength="300" placeholder="이미지 URL">
    </div>

    <div class="d-grid col-3">
        <button type="submit" class="btn btn-primary">등록</button>
    </div>
</form>

   