<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
  width: 235px;
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
				<li><a href="/books">통합검색</a></li>
				<li><a href="/books?type=class">주제별검색</a></li>
				<li><a href="/books?type=loan">대출베스트</a></li>
				<li><a href="/books?type=like">인기도서</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">열린마당</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/articles?type=notice">공지사항</a></li>
				<li><a href="/articles?type=fnq">자주 묻는 질문</a></li>
				<li><a href="/articles?type=qna">Q&A</a></li>
				<li><a href="/articles?type=req">희망 도서 신청</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">내 서재</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/members/${membersId}">내 정보</a></li>
				<li><a href="/members/${membersId}/book-history">도서 이용 정보</a></li>
				<li><a href="/members/${membersId}/book-like">관심 도서 목록</a></li>
				<li><a href="/members/${membersId}/book-req">도서 신청 목록</a></li>
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
				<li><a href="/etc/61">로그인</a></li>
				<li><a href="/etc/62">가입 여부 확인</a></li>
				<li><a href="/etc/63">비밀번호 재발급</a></li>
				<li><a href="/etc/64">회원가입</a></li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title">관리자 페이지</div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/admin/91">회원 관리</a></li>
				<li><a href="/admin/92">게시글 관리</a></li>
				<li><a href="/admin/93">도서 관리</a></li>
			</ul>
		</div>
	</div>

</div>
