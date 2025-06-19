<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
.sitemap {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 60px;
  padding: 50px 30px;
}

.sitemap > div {
  border: 1px solid #ddd;
  border-radius: 16px;
  background-color: #ffffff;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
  padding: 30px 30px;
  width: 300px;
  min-height: 240px;
  transition: all 0.2s ease-in-out;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

.sitemap > div:hover {
  transform: translateY(-6px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.sitemap_title {
  font-size: 1.4rem;
  font-weight: 700;
  color: #003366;
  margin-bottom: 20px;
  border-bottom: 2px solid #003366;
  padding-bottom: 10px;
}

.sitemap_content ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sitemap_content li {
  margin: 10px 0;
}

.sitemap_content a {
  text-decoration: none;
  color: #0056b3;
  font-weight: 500;
  transition: color 0.15s ease-in-out;
}

.sitemap_content a:hover {
  color: #0d6efd;
  text-decoration: underline;
}
</style>

<div class="sitemap">

	<div>
		<div class="sitemap_title">자료검색</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/books">통합검색</a></li>
				<li><a href="/public/books?type=class">주제별검색</a></li>
				<li><a href="/public/books?type=loan">대출베스트</a></li>
				<li><a href="/public/books?type=like">인기도서</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">열린마당</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/articles/not">공지사항</a></li>
				<li><a href="/public/articles/faq">자주 묻는 질문</a></li>
				<li><a href="/public/articles/qna">Q&A</a></li>
				<li><a href="/private/articles/req">희망 도서 신청</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">내 서재</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/private/members/${membersId}">내 정보</a></li>
				<li><a href="/private/members/${membersId}/book-history">도서 이용 정보</a></li>
				<li><a href="/private/members/${membersId}/book-like">관심 도서 목록</a></li>
				<li><a href="/private/members/${membersId}/book-req">도서 신청 목록</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">도서관 소개</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/etc/41">도서관 정보</a></li>
				<li><a href="/etc/42">연혁</a></li>
				<li><a href="/etc/43">도서 현황</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">이용 안내</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/etc/51">이용시간/휴관일</a></li>
				<li><a href="/etc/52">회원가입 안내</a></li>
				<li><a href="/etc/53">도서 이용 안내</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">홈페이지 이용 안내</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/etc/71">사이트맵</a></li>
				<li><a href="/etc/72">이용약관</a></li>
				<li><a href="/etc/73">개인정보처리방침</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">회원 정보</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/auth/login">로그인</a></li>
				<li><a href="/public/members/check">아이디 찾기</a></li>
				<li><a href="/public/members/repass">비밀번호 재발급</a></li>
				<li><a href="/public/members/register">회원가입</a></li>
			</ul>
		</div>
	</div>
	
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div>
		<div class="sitemap_title">관리자 페이지</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/admin/members">회원 관리</a></li>
				<li><a href="/admin/articles">게시글 관리</a></li>
				<li><a href="/admin/books">도서 관리</a></li>
				<li><a href="/admin/tokens">차단된 토큰 관리</a></li>
			</ul>
		</div>
	</div>
</sec:authorize>

</div>
