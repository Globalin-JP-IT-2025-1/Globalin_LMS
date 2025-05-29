<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/main.css">

<div class="main">

	<div class="main_1">
		<div class="main1_item1"><label id="searchType">통합검색</label></div>
		<div class="main1_item2">
			<input type="text" id="searchInput" placeholder="검색어를 입력하세요" maxlength="20">
			<button id="searchBtn">검색</button>
		</div>
	</div>
	
	<div class="main_2">
		<div class="main_2_1">로그인</div>
		<div class="main_2_2">추천도서</div>
		<div class="main_2_3">공지사항</div>
	</div>
	
	<div class="main_3">
		<button class="main_3_item">간편메뉴1</button>
		<button class="main_3_item">간편메뉴2</button>
		<button class="main_3_item">간편메뉴3</button>
		<button class="main_3_item">간편메뉴4</button>
		<button class="main_3_item">간편메뉴5</button>
	</div>
	
	<div class="main_4">도서관간략소개</div>
	
	<div class="main_5">베너</div>
	
</div>