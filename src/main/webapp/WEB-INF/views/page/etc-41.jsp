<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 도서관 소개 > 도서관 정보 -->

<style>
.etc_41 {
	display: grid;
	grid-template-areas: "a b" "c c";
	gap: 10px; /* 간격 조정 */
}

.etc_41 .img, .etc_41 .map {
	width: 400px;
	height: 300px;
}

.etc_41 .img {
	grid-area: a;
}

.etc_41 .map {
	grid-area: b;
}

.etc_41 .info {
	grid-area: c;
}

.etc_41 .info table {
	border-spacing: 0px;
	border: 0.5px solid var(- -main-color);
}

.etc_41 .info td {
	border: 0.5px solid var(- -main-color);
	padding: 10px;
}

.etc_41 .info table {
	width: 600px
}

.etc_41 .info .title {
	width: 300px;
	background-color: var(- -sub-color);
}

.etc_41 .info .content {
	width: 500px;
}
</style>

<div class="etc_41">

	<div class="img">
		<i class="bi bi-bank"></i> 도서관 전경<br>
		<!-- <img src=""> -->
	</div>
	<div class="map">
		<i class="bi bi-geo-alt"></i> 도서관 위치<br>
	</div>


	<div class="info">
		<i class="bi bi-book"></i> 도서관 정보<br>
		<table>
			<tr>
				<td class="title">도서관명</td>
				<td class="content">글로벌인 도서관</td>
			</tr>
			<tr>
				<td class="title">주소</td>
				<td class="content">서울특별시 영등포구 가나다로 1</td>
			</tr>
			<tr>
				<td class="title">운영시간</td>
				<td class="content">평일 10:00 ~ 21:00<br>휴일 10:00 ~ 17:00
				</td>
			</tr>
			<tr>
				<td class="title">정기 휴관일</td>
				<td class="content">매주 월요일</td>
			</tr>
			<tr>
				<td class="title">개관일</td>
				<td class="content">2025-06-01</td>
			</tr>
		</table>
	</div>

</div>