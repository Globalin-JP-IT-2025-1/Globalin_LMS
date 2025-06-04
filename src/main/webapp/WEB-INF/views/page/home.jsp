<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/home.css">

<div class="home">
	<div class="home_1_bg">
		<div class="home_1">
			<div class="home1_item1">
				<label id="searchType">통합검색</label>
			</div>
			<div class="home1_item2">
				<input type="text" id="searchInput" placeholder="검색어를 입력하세요" maxlength="20">
				<button id="searchBtn">검색</button>
			</div>
		</div>
	</div>

	<div class="home_2_bg">
		<div class="home_2">
			<div class="home_2_1">
				<a href="/login">로그인</a><br>
				~~ DB 테스트 ~~<br>
				<a href="/register">회원가입</a><br>
				<a href="/members">회원 목록</a><br>
			</div>
			<div class="home_2_2">추천도서</div>
			<div class="home_2_3">공지사항</div>
		</div>
	</div>

	<div class="home_3_bg">
		<div class="home_3">
			<button class="home_3_item">간편메뉴1</button>
			<button class="home_3_item">간편메뉴2</button>
			<button class="home_3_item">간편메뉴3</button>
			<button class="home_3_item">간편메뉴4</button>
			<button class="home_3_item">간편메뉴5</button>
		</div>
	</div>

	<div class="home_4_bg">
		<div class="home_4">도서관간략소개</div>
	</div>

	<div class="home_5_bg">
		<div class="home_5">베너</div>
	</div>
</div>