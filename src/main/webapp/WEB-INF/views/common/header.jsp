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
							<td><a href="/public/auth/login">로그인</a></td>
							<td>|</td>
							<td><a href="/public/members/register">회원가입</a></td>
							<td>|</td>
							<td><a href="/etc/71">사이트맵</a></td>
						</tr>
					</table>
				</div>

				<div class="h_member_info">
					<a href="/private/members/3">가길동</a> 님
				</div>

				<%-- <c:if test="${not empty membersId}">
					<div>
						<a href="/user/mypage/${membersId}" id="mypage">
							<c:out value="${empty membersId ? '게스트' : membersId}" />
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
							<li class="h_submenu_item"><a href="/books">통합검색</a></li>
							<li class="h_submenu_item"><a href="/books?type=class">주제별검색</a></li>
							<li class="h_submenu_item"><a href="/books?type=loan">대출베스트</a></li>
							<li class="h_submenu_item"><a href="/books?type=like">인기도서</a></li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item"><a href="/articles?type=notice">공지사항</a></li>
							<li class="h_submenu_item"><a href="/articles?type=fnq">자주묻는질문</a></li>
							<li class="h_submenu_item"><a href="/articles?type=qna">Q&A</a></li>
							<li class="h_submenu_item"><a href="/articles?type=req">희망도서신청</a></li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item"><a href="/etc/41">도서관 정보</a></li>
							<li class="h_submenu_item"><a href="/etc/42">연혁</a></li>
							<li class="h_submenu_item"><a href="/etc/43">도서 현황</a></li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item"><a href="/etc/51">이용시간/휴관일</a></li>
							<li class="h_submenu_item"><a href="/etc/52">회원가입 안내</a></li>
							<li class="h_submenu_item"><a href="/etc/53">도서 이용 안내</a></li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item"><a href="/members/${membersId}">내 정보</a></li>
							<li class="h_submenu_item"><a href="/members/${membersId}/book-history">도서 이용 정보</a></li>
							<li class="h_submenu_item"><a href="/members/${membersId}/book-like">관심 도서 목록</a></li>
							<li class="h_submenu_item"><a href="/members/${membersId}/book-req">도서 신청 목록</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>