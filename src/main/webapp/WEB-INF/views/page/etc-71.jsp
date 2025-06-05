<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 홈페이지 이용안내 - 사이트맵 -->

<style>
	
	.sitemap {
		display: grid;
		grid-template-areas:
		  "a b c"
		  "d e f"
		  "g h .";
		gap: 10px; /* 간격 조정 */
	}

	.sitemap_1 { grid-area: a; }
	.sitemap_2 { grid-area: b; }
	.sitemap_3 { grid-area: c; }
	.sitemap_4 { grid-area: d; }
	.sitemap_5 { grid-area: e; }
	.sitemap_6 { grid-area: f; }
	.sitemap_7 { grid-area: g; }
	.sitemap_8 { grid-area: h; }
	
	.sitemap_content ul {
		list-style-type: none;
		padding-left: 0;
		margin-left: 0
	}

</style>

<div class="sitemap">
	<div class="sitemap_1">
		<div class="sitemap_title">자료검색</div>
		<div class="sitemap_content">
			<ul>
				<li>통합검색</li>
				<li>주제별검색</li>
				<li>대출 베스트</li>
				<li></li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_2">
		<div class="sitemap_title">열린마당</div>
		<div class="sitemap_content">
			<ul>
				<li>공지사항</li>
				<li>자주 묻는 질문</li>
				<li>Q&A</li>
				<li>희망 도서 신청</li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_3">
		<div class="sitemap_title">내 서재</div>
		<div class="sitemap_content">
			<ul>
				<li>내 정보</li>
				<li>도서 이용 정보</li>
				<li>관심 도서 목록</li>
				<li>도서 신청 목록</li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_4">
		<div class="sitemap_title">도서관 소개</div>
		<div class="sitemap_content">
			<ul>
				<li>도서관 정보</li>
				<li>연혁</li>
				<li>도서 현황</li>
				<li></li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_5">
		<div class="sitemap_title">이용 안내</div>
		<div class="sitemap_content">
			<ul>
				<li>이용시간/휴관일</li>
				<li>회원가입 안내</li>
				<li>도서 이용 안내</li>
				<li></li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_6">
		<div class="sitemap_title">홈페이지 이용 안내</div>
		<div class="sitemap_content">
			<ul>
				<li>사이트맵</li>
				<li>이용약관</li>
				<li>개인정보처리방침</li>
				<li></li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_7">
		<div class="sitemap_title">회원 정보</div>
		<div class="sitemap_content">
			<ul>
				<li>로그인</li>
				<li>가입 여부 확인</li>
				<li>비밀번호 재발급</li>
				<li>회원가입</li>
			</ul>
		</div>
	</div>
	
	<div class="sitemap_8">
		<div class="sitemap_title">관리자</div>
		<div class="sitemap_content">
			<ul>
				<li>회원 관리</li>
				<li>탈퇴회원 토큰 관리</li>
				<li>도서 추가/수정</li>
				<li></li>
			</ul>
		</div>
	</div>
	
</div>