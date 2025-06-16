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
				<p>회원 로그인</p>
				<div class="h2_1_div1">
					<input type="text" id="username" placeholder="아이디">
					<input type="text" id="password" placeholder="비밀번호">
				</div>
				<div class="h2_1_div2">
					<button class="loginbtn" onclick="loginProc()">로그인</button>
				</div>
				<div class="h2_1_div3">
					<a href="#">회원가입</a>&nbsp;|
					<a href="#">가입여부 확인</a>&nbsp;|
					<a href="#">비밀번호 재발급</a>
				</div>
			</div>
			
			<div class="home_2_2">
			  <div class="h2_2_top">
			    <div class="h2_2_left">
			      <a href="#" class="active">추천도서</a> |
			      <a href="#">인기도서</a> |
			      <a href="#">신작도서</a>
			    </div>
			    <div class="h2_2_right">
			      <a href="#"><i class="bi bi-plus-circle"></i></a>
			    </div>
			  </div>
			
			  <div class="book_list">
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book1.jpg" alt="책1" class="book_img">
			      <div class="book_title">책제목1<br><span>저자1</span></div>
			    </div>
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book2.jpg" alt="책2" class="book_img">
			      <div class="book_title">책제목2<br><span>저자2</span></div>
			    </div>
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book3.jpg" alt="책3" class="book_img">
			      <div class="book_title">책제목3<br><span>저자3</span></div>
			    </div>
			  </div>
			</div>

			<div class="home_2_3">
				<div class="h2_3_div1">
					<p>공지사항</p>
					<a href="#"><i class="bi bi-plus-circle"></i></a>
				</div>
			</div>
		</div>
	</div>
	<div class="home_3_bg">
	  <div class="home_3">
	    <div class="home_3_item" onclick="location.href='/public/etc/51'">
	    	<i class="bi bi-info-circle"></i>이용안내
    	</div>
	    <div class="home_3_item" onclick="location.href='/public/etc/53'">
	    	<i class="bi bi-book"></i>대출/반납
    	</div>
	    <div class="home_3_item" onclick="location.href='/private/articles/req'">
	    	<i class="bi bi-pencil"></i> 희망도서 신청
    	</div>
	    <div class="home_3_item" onclick="location.href='/public/books/loan'">
	    	<i class="bi bi-graph-up-arrow"></i>대출 베스트
    	</div>
	    <div class="home_3_item" onclick="location.href='/private/members/${h_membersId}/book-like'">
	    	<i class="bi bi-bookmark-heart"></i>관심도서 목록
    	</div>
	  </div>
	</div>
	
	<div class="home_4_bg">
		<div class="home_4">
			<div class="home_4_left">
				<div class="lib_title"><p><i class="bi bi-bank"></i>&nbsp;도서관 전경</p></div>
				<img class="lib_img" src="${pageContext.request.contextPath}/resources/images/library.png"/>
			</div>
			<div class="home_4_right">
				<p class="lib_welcome">글로벌인도서관 홈페이지 방문을 환영합니다.</p>
				<p>저희 글로벌인 도서관은 2025년 6월 1일 개관하였습니다.<br>
				여러분들의 많은 관심과 이용 부탁드립니다.<br>
				다양한 장르의 책을 준비하였으니 대여를 원하시는 분들은 회원가입 후 도서관에 방문하여 회원카드를<br>
				발급하여주시기 바랍니다.
				</p>
				<table class="lib_table">
					<tr>
						<th>이용시간</th>
						<td>평일 : 오전10시~오후10시<br>휴일 : 오전10시~오후5시30분</td>
					</tr>
					<tr>
						<th>정기 휴관일</th>
						<td>매주 월요일</td>
					</tr>
				</table>
				<div class="lib_btn_div">
					<button class="lib_btn" onclick="location.href='/public/etc/41'">도서관안내 &gt;</button>
					<button class="lib_btn" onclick="location.href='/public/etc/51'">이용안내 &gt;</button>
				</div>
			</div>
		</div>
	</div>
	<div class="home_5_bg">
	  	<div class="home_5">
			<div class="banner_wrapper">
			  <div class="banner_track" id="bannerTrack">
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner1.jpg" alt="배너1"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner2.jpg" alt="배너2"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner3.jpg" alt="배너3"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner4.jpg" alt="배너4"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner5.jpg" alt="배너5"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner6.jpg" alt="배너6"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner7.jpg" alt="배너7"></div>
			  </div>
			</div>

		</div>
	</div>

</div>


<script
	src="${pageContext.request.contextPath}/resources/static/js/home.js"></script>

