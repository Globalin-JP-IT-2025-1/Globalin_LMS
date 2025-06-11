<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 도서관 소개 > 도서관 정보 -->

<style>
.etc_41_wrap {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}
.etc_41 {
	display: grid;
	grid-template-areas: "a b" "c c";
	gap: 50px;
	padding: 0 40px; /* 좌우 공간 확보 */
}


.etc_41 .card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 5px 20px 20px 20px; /* 위는 0, 나머지는 그대로 */
}

.etc_41 h5 {
	margin-top: 5px;
	margin-bottom: 5px;  /* 기존 10~15px보다 줄임 */
	font-size: 18px;
	color: #1b3a57;
}

.etc_41 .img {
	width: 460px;
	height: 350px;
	grid-area: a;
	display: flex;
	margin-left: 0px; /* 원하는 만큼 조절 */
	flex-direction: column;	
	align-items: flex-start;   /* 제목 왼쪽 정렬 */
	justify-content: flex-start;
}

.etc_41 .img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 8px;
}


.etc_41 .map {
	width: 460px;
	height: 350px;
	grid-area: b;
	display: flex;
	flex-direction: column;
	align-items: flex-start;   /* 제목 왼쪽 정렬 */
	justify-content: flex-start;
	gap: 7px;	
}

.etc_41 .info {
	grid-area: c;
	width: 100%;
	max-width: 1010px;
	margin: 0 auto;
}


.etc_41 .info table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #dee2e6;
}

.etc_41 .info th,
.etc_41 .info td {
	border: 1px solid #dee2e6;
	padding: 12px 16px;
	text-align: left;
}

.etc_41 .info th {
	background-color: #f1f3f5;
	width: 30%;
	color: #003366;
	font-weight: bold;
}

.etc_41 iframe {
	width: 100%;
	height: 100%;
	border: 0;
	border-radius: 8px;
}
</style>

<div class="etc_41_wrap">
	<div class="etc_41">

		<!-- 1. 도서관 전경 -->
		<div class="img card">
			<h5><i class="bi bi-bank"></i>&nbsp;도서관 전경</h5>
			<img src="${pageContext.request.contextPath}/resources/images/library.png"/>
		</div>

		<!-- 2. 도서관 위치 -->
		<div class="map card">
			<h5><i class="bi bi-geo-alt"></i>&nbsp;도서관 위치</h5>
			<iframe
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3164.811279708046!2d126.90326121530884!3d37.52094883425388!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c9efba69e5a99%3A0x4e7d5d6e53c3df67!2z7ISc7Jq47Yq567OE7IucIOuPmeq1rCDslYTsubTrj5kgMQ!5e0!3m2!1sko!2skr!4v1717588943233!5m2!1sko!2skr"
				allowfullscreen=""
				loading="lazy"
				referrerpolicy="no-referrer-when-downgrade">
			</iframe>
		</div>

		<!-- 3. 도서관 정보 -->
		<div class="info card">
			<h5><i class="bi bi-book"></i>&nbsp;도서관 안내</h5>
			<table>
				<tr>
					<th>도서관명</th>
					<td>글로벌인 도서관</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>서울특별시 영등포구 가나다로 1</td>
				</tr>
				<tr>
					<th>운영시간</th>
					<td>평일 10:00 ~ 21:00<br>휴일 10:00 ~ 17:00</td>
				</tr>
				<tr>
					<th>정기 휴관일</th>
					<td>매주 월요일</td>
				</tr>
				<tr>
					<th>개관일</th>
					<td>2025-06-01</td>
				</tr>
			</table>
		</div>

	</div>
</div>
