<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="header_1">
	<div class="h1_item" id="h1_1">
		<div>
			<a href="/home"> <img
				src="${pageContext.request.contextPath}/resources/images/logo.png"
				alt="home" width="100px"></a> <img
				src="${pageContext.request.contextPath}/resources/images/title.png"
				alt="globalin-library" width="300px">
		</div>
	</div>
	<div class="h1_item" id="h1_2"></div>
	<div class="h1_item" id="h1_3">
		<div>
			<a href="/home">홈</a> | <a href="/user/loginForm/0" id="loginForm">로그인</a>
			| <a href="/user/regForm" id="regForm">회원가입</a> | <a href="/login">사이트맵</a>
		</div>
		<c:if test="${not empty userid}">
			<div>
				<a href="/user/mypage/${userid}" id="mypage"> <c:out
						value="${empty userid ? '게스트' : userid}" />
				</a> 님 환영합니다!
			</div>
		</c:if>
	</div>
</div>

<div class="header_2">
	<div class="header_menu">
		<div class="menu_container">
			<button class="menu_toggleBtn" id="menu1_toggleBtn">자료검색</button>
			<div class="menu_con_blank">|</div>
			<button class="menu_toggleBtn" id="menu2_toggleBtn">열린마당</button>
			<div class="menu_con_blank">|</div>
			<button class="menu_toggleBtn" id="menu3_toggleBtn">도서관안내</button>
			<div class="menu_con_blank">|</div>
			<button class="menu_toggleBtn" id="menu4_toggleBtn">이용안내</button>
			<div class="menu_con_blank">|</div>
			<button class="menu_toggleBtn" id="menu5_toggleBtn">내서재</button>
			<div class="menu_con_blank">|</div>
		</div>
		<div class="menu_all">
			<button class="menuAll_toggleBtn" id="menuAll_toggleBtn">∨</button>
		</div>
	</div>

	<div class="hidden" id="header_submenu">
		<div class="header_submenu">
			<div class="menu_submenu" id="menu1_submenu">
				<ul>
					<li class="menu_submenu_item"><a href="#">통합검색</a></li>
					<li class="menu_submenu_item"><a href="#">주제별검색</a></li>
					<li class="menu_submenu_item"><a href="#">대출베스트</a></li>
					<li class="menu_submenu_item"><a href="#">인기도서</a></li>
				</ul>
			</div>
			<div class="menu_submenu_blank"></div>
			<div class="menu_submenu" id="menu2_submenu">
				<ul>
					<li class="menu_submenu_item">공지사항</li>
					<li class="menu_submenu_item">자주묻는질문</li>
					<li class="menu_submenu_item">Q&A</li>
					<li class="menu_submenu_item">희망도서신청</li>
				</ul>
			</div>
			<div class="menu_submenu_blank"></div>
			<div class="menu_submenu" id="menu3_submenu">
				<ul>
					<li class="menu_submenu_item">인사말</li>
					<li class="menu_submenu_item">연혁</li>
					<li class="menu_submenu_item">도서현황</li>
				</ul>
			</div>
			<div class="menu_submenu_blank"></div>
			<div class="menu_submenu" id="menu4_submenu">
				<ul>
					<li class="menu_submenu_item">이용시간 및 휴관일</li>
					<li class="menu_submenu_item">회원가입</li>
					<li class="menu_submenu_item">도서대출/반납/예약</li>
				</ul>
			</div>
			<div class="menu_submenu_blank"></div>
			<div class="menu_submenu" id="menu5_submenu">
				<ul>
					<li class="menu_submenu_item">기본정보</li>
					<li class="menu_submenu_item">도서이용정보</li>
					<li class="menu_submenu_item">관심자료목록</li>
					<li class="menu_submenu_item">도서신청목록</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>