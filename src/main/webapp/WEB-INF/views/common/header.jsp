<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<div class="header">
	<div class="h_1_bg">
		<div class="h_1">
			<div class="h1_1">
				<table>
					<tr>
						<td>🌐</td>
						<td class="current_lang"><a href="#" class="lang-btn" id="kr">한글</a></td>
						<td class=""><a href="#" class="lang-btn" id="jp">日本語</a></td>
						<td class=""><a href="#" class="lang-btn" id="en">English</a></td>
					</tr>
				</table>
			</div>
			<div class="h1_2">
				<div class="logo">
					<a href="/"> <img
						src="${pageContext.request.contextPath}/resources/images/title.png"
						alt="globalin-library">
					</a>
				</div>
			</div>
			<div class="h1_3">
				<div class="h_mini_menu">
					<table>
						<tr>
							<td><a href="/">홈</a></td>
							<td>|</td>
							<td><a href="/login" id="loginForm">로그인</a></td>
							<td>|</td>
							<td><a href="/register" id="regForm">회원가입</a></td>
							<td>|</td>
							<td><a href="/etc/92">사이트맵</a></td>
						</tr>
					</table>
				</div>

				<div class="h_member_info">
					<a href="#">가길동</a> 님
				</div>

				<%-- <c:if test="${not empty memberId}">
					<div>
						<a href="/user/mypage/${memberId}" id="mypage">
							<c:out value="${empty memberId ? '게스트' : memberId}" />
						</a> 님 환영합니다!
					</div>
				</c:if> --%>
			</div>
		</div>
	</div>

	<div class="h_2_bg">
		<div class="h_2">
			<div class="h2_1">
				<div class="menu_each">
					<button class="menu_e_toggle" id="menu_1_toggle">자료검색</button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_2_toggle">열린마당</button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_3_toggle">도서관안내</button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_4_toggle">이용안내</button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_5_toggle">내서재</button>
					<div class="menu_e_blank">|</div>
				</div>
				<div class="menu_all">
					<button class="menu_a_toggle" id="menu_a_toggle">∨</button>
				</div>
			</div>

			<!-- display: none / block -->
			<div class="hidden" id="h_submenu">
				<!-- display: flex -->
				<div class="h2_2">
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item"><a href="#">통합검색</a></li>
							<li class="h_submenu_item"><a href="#">주제별검색</a></li>
							<li class="h_submenu_item"><a href="#">대출베스트</a></li>
							<li class="h_submenu_item"><a href="#">인기도서</a></li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">공지사항</li>
							<li class="h_submenu_item">자주묻는질문</li>
							<li class="h_submenu_item">Q&A</li>
							<li class="h_submenu_item">희망도서신청</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">인사말</li>
							<li class="h_submenu_item">연혁</li>
							<li class="h_submenu_item">도서현황</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">이용시간 및 휴관일</li>
							<li class="h_submenu_item">회원가입</li>
							<li class="h_submenu_item">도서대출/반납/예약</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">기본정보</li>
							<li class="h_submenu_item">도서이용정보</li>
							<li class="h_submenu_item">관심자료목록</li>
							<li class="h_submenu_item">도서신청목록</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>