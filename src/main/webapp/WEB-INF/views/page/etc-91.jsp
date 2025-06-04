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
		<div class="sitemap_title">
		자료검색
		</div>
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
		<div class="sitemap_title">
		열린마당
		</div>
		<div class="sitemap_content">
			<ul>
				<li>통합검색</li>
				<li>주제별검색</li>
				<li>대출 베스트</li>
				<li></li>
			</ul>
		</div>
	</div>
</div>