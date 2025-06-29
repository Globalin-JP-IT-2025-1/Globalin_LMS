<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="bookList" value="${bookList}" />

<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
.bookSearchClass a:hover {
	text-decoration: underline !important;
}

.bookList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.bookList td, .bookList th {
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
}

/* 각 열 너비 */
.bookList td:nth-child(1), .bookList th:nth-child(1) { width: 5% !important; }
.bookList td:nth-child(2), .bookList th:nth-child(2) { width: 10% !important; }
.bookList td:nth-child(3), .bookList th:nth-child(3) { width: 65% !important; }
.bookList td:nth-child(4), .bookList th:nth-child(4) { width: 10% !important; }
.bookList td:nth-child(5), .bookList th:nth-child(5) { width: 5% !important; }
.bookList td:nth-child(6), .bookList th:nth-child(6) { width: 5% !important; }

.accordion-button {
	border-radius: 0.5rem !important;
	margin-bottom: 0.5rem;
}

</style>

<div class="container" style="width: 70%; max-width: 70%;">
	<div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse000"
				aria-expanded="false" aria-controls="collapse000">000 총류</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse100"
				aria-expanded="false" aria-controls="collapse100">100 철학</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse200"
				aria-expanded="false" aria-controls="collapse200">200 종교</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse300"
				aria-expanded="false" aria-controls="collapse300">300 사회과학
			</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse400"
				aria-expanded="false" aria-controls="collapse400">400 자연과학
			</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse500"
				aria-expanded="false" aria-controls="collapse500">500 기술과학
			</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse600"
				aria-expanded="false" aria-controls="collapse600">600 예술</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse700"
				aria-expanded="false" aria-controls="collapse700">700 언어</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse800"
				aria-expanded="false" aria-controls="collapse800">800 문학</button>
		</div>
		<div class="col">
			<button class="accordion-button collapsed w-100" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapse900"
				aria-expanded="false" aria-controls="collapse900">900 역사</button>
		</div>
		<div class="col"></div>
		<div class="col"></div>
	</div>
	<div class="accordion" id="bookClassAccordion">
		<!-- 000 총류 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading000"></h2>
			<div id="collapse000" class="accordion-collapse collapse"
				aria-labelledby="heading000" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=010"
							class="text-decoration-none text-dark">010 도서관, 서지학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=020"
							class="text-decoration-none text-dark">020 문헌정보학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=030"
							class="text-decoration-none text-dark">030 백과사전</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=040"
							class="text-decoration-none text-dark">040 강연집, 수필집, 연설문집</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=050"
							class="text-decoration-none text-dark">050 일반 연속간행물</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=060"
							class="text-decoration-none text-dark">060 일반학회, 단체, 협회, 기관</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=070"
							class="text-decoration-none text-dark">070 신문, 언론, 저널리즘</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=080"
							class="text-decoration-none text-dark">080 일반전집</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=090"
							class="text-decoration-none text-dark">090 향토자료</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 100 철학 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading100"></h2>
			<div id="collapse100" class="accordion-collapse collapse"
				aria-labelledby="heading100" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=110"
							class="text-decoration-none text-dark">110 형이상학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=120"
							class="text-decoration-none text-dark">120 인식론, 인과론</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=130"
							class="text-decoration-none text-dark">130 인간학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=140"
							class="text-decoration-none text-dark">140 경험론, 합리론</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=150"
							class="text-decoration-none text-dark">150 심리학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=160"
							class="text-decoration-none text-dark">160 논리학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=170"
							class="text-decoration-none text-dark">170 윤리학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=180"
							class="text-decoration-none text-dark">180 동양철학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=190"
							class="text-decoration-none text-dark">190 서양철학</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 200 종교 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading200"></h2>
			<div id="collapse200" class="accordion-collapse collapse"
				aria-labelledby="heading200" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=210"
							class="text-decoration-none text-dark">210 비교종교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=220"
							class="text-decoration-none text-dark">220 불교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=230"
							class="text-decoration-none text-dark">230 기독교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=240"
							class="text-decoration-none text-dark">240 천주교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=250"
							class="text-decoration-none text-dark">250 개신교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=260"
							class="text-decoration-none text-dark">260 기타 제종교</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=270"
							class="text-decoration-none text-dark">270 신화, 민속신앙</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=280"
							class="text-decoration-none text-dark">280 종교사회학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=290"
							class="text-decoration-none text-dark">290 종교사</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 300 사회과학 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading300"></h2>
			<div id="collapse300" class="accordion-collapse collapse"
				aria-labelledby="heading300" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=310"
							class="text-decoration-none text-dark">310 통계학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=320"
							class="text-decoration-none text-dark">320 정치학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=330"
							class="text-decoration-none text-dark">330 경제학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=340"
							class="text-decoration-none text-dark">340 법학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=350"
							class="text-decoration-none text-dark">350 행정학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=360"
							class="text-decoration-none text-dark">360 사회학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=370"
							class="text-decoration-none text-dark">370 교육학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=380"
							class="text-decoration-none text-dark">380 풍속, 민속학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=390"
							class="text-decoration-none text-dark">390 국방, 군사학</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 400 자연과학 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading400"></h2>
			<div id="collapse400" class="accordion-collapse collapse"
				aria-labelledby="heading400" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=410"
							class="text-decoration-none text-dark">410 수학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=420"
							class="text-decoration-none text-dark">420 물리학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=430"
							class="text-decoration-none text-dark">430 화학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=440"
							class="text-decoration-none text-dark">440 천문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=450"
							class="text-decoration-none text-dark">450 지학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=460"
							class="text-decoration-none text-dark">460 광물학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=470"
							class="text-decoration-none text-dark">470 생명과학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=480"
							class="text-decoration-none text-dark">480 식물학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=490"
							class="text-decoration-none text-dark">490 동물학</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 500 기술과학 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading500"></h2>
			<div id="collapse500" class="accordion-collapse collapse"
				aria-labelledby="heading500" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=510"
							class="text-decoration-none text-dark">510 의학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=520"
							class="text-decoration-none text-dark">520 농업</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=530"
							class="text-decoration-none text-dark">530 공업일반</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=540"
							class="text-decoration-none text-dark">540 건축공학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=550"
							class="text-decoration-none text-dark">550 기계공학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=560"
							class="text-decoration-none text-dark">560 전기공학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=570"
							class="text-decoration-none text-dark">570 화학공학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=580"
							class="text-decoration-none text-dark">580 제조업</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=590"
							class="text-decoration-none text-dark">590 가정학, 생활과학</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 600 예술 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading600"></h2>
			<div id="collapse600" class="accordion-collapse collapse"
				aria-labelledby="heading600" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=610"
							class="text-decoration-none text-dark">610 조형예술</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=620"
							class="text-decoration-none text-dark">620 건축예술</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=630"
							class="text-decoration-none text-dark">630 조각</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=640"
							class="text-decoration-none text-dark">640 공예, 장식미술</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=650"
							class="text-decoration-none text-dark">650 회화</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=660"
							class="text-decoration-none text-dark">660 사진술</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=670"
							class="text-decoration-none text-dark">670 음악</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=680"
							class="text-decoration-none text-dark">680 연극, 영화</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=690"
							class="text-decoration-none text-dark">690 오락, 스포츠</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 700 언어 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading700"></h2>
			<div id="collapse700" class="accordion-collapse collapse"
				aria-labelledby="heading700" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=710"
							class="text-decoration-none text-dark">710 언어학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=720"
							class="text-decoration-none text-dark">720 한국어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=730"
							class="text-decoration-none text-dark">730 중국어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=740"
							class="text-decoration-none text-dark">740 일본어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=750"
							class="text-decoration-none text-dark">750 영어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=760"
							class="text-decoration-none text-dark">760 독일어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=770"
							class="text-decoration-none text-dark">770 프랑스어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=780"
							class="text-decoration-none text-dark">780 스페인어</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=790"
							class="text-decoration-none text-dark">790 기타 언어</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 800 문학 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading800"></h2>
			<div id="collapse800" class="accordion-collapse collapse"
				aria-labelledby="heading800" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=810"
							class="text-decoration-none text-dark">810 한국문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=820"
							class="text-decoration-none text-dark">820 중국문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=830"
							class="text-decoration-none text-dark">830 일본문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=840"
							class="text-decoration-none text-dark">840 영어문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=850"
							class="text-decoration-none text-dark">850 독일문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=860"
							class="text-decoration-none text-dark">860 프랑스문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=870"
							class="text-decoration-none text-dark">870 스페인문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=880"
							class="text-decoration-none text-dark">880 기타 문학</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=890"
							class="text-decoration-none text-dark">890 문학이론</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 900 역사 -->
		<div class="accordion-item">
			<h2 class="accordion-header d-none" id="heading900"></h2>
			<div id="collapse900" class="accordion-collapse collapse"
				aria-labelledby="heading900" data-bs-parent="#bookClassAccordion">
				<div class="accordion-body p-0">
					<ul class="list-group list-group-flush">
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=910"
							class="text-decoration-none text-dark">910 아시아사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=920"
							class="text-decoration-none text-dark">920 유럽사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=930"
							class="text-decoration-none text-dark">930 아프리카사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=940"
							class="text-decoration-none text-dark">940 북아메리카사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=950"
							class="text-decoration-none text-dark">950 남아메리카사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=960"
							class="text-decoration-none text-dark">960 오세아니아사</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=970"
							class="text-decoration-none text-dark">970 지리</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=980"
							class="text-decoration-none text-dark">980 여행</a></li>
						<li class="list-group-item border-0"><a
							href="public/books/class?class_no=990"
							class="text-decoration-none text-dark">990 전기</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 도서 목록 -->
<div class="container mt-4">
	<!-- 요약 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
    </div>
    
    <!-- 도서 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover bookList">
	    	<thead>
	        	<tr>
	        		<th>NO</th>
	        		<th>도서 표지</th>
	        		<th>도서 정보</th>
	        		<th>도서 상태</th>
	        		<th>조회수</th>
	        		<th>리뷰수</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
	        		<c:when test="${empty bookList}">
	        			<td colspan="6" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty bookList}">
			            <c:forEach var="i" begin="0" end="${fn:length(bookList) - 1}" step="1">
			                <tr onclick="location.href='/public/articles/not/${bookList[i].booksId}'">
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>
				                    <img src="${bookList[i].imageLink}"
				                        alt="${bookList[i].title} 책 표지" width="50">
				                </td>
				                <td>
				                    <div class="text-secondary mb-1">
				                    	총류 > 총류
				                    </div>
				                    <div class="fw-bold fs-4 mb-2">${bookList[i].title}</div>
				                    <div class="d-flex flex-wrap mb-2 gap-3">
				                        <div><span class="fw-semibold">저자:</span> ${bookList[i].author}</div>
				                        <div><span class="fw-semibold">출판사:</span> ${bookList[i].publisher}</div>
				                        <div><span class="fw-semibold">출판연도:</span> <fmt:formatDate value="${bookList[i].publishDate}" pattern="yyyy" /></div>
				                    </div>
				                    <div class="d-flex flex-wrap mb-2 gap-3">
				                        <div><span class="fw-semibold">ISBN:</span> ${bookList[i].isbn}</div>
				                        <div><span class="fw-semibold">분류기호:</span> ${bookList[i].category}</div>
				                        <div><span class="fw-semibold">도서관:</span> 글로벌인 도서관</div>
				                        <div><span class="fw-semibold">자료실:</span> 일반자료실</div>
				                    </div>
				                </td>
				                <td>
				                    <div class="d-flex flex-column gap-2">
				                        <div class="mb-2 text-danger fw-semibold">
				                        	${bookList[i].status}
				                        </div>
				                        <button class="btn btn-secondary btn-sm" disabled>도서예약불가</button>
				                        <button class="btn btn-outline-success btn-sm">관심도서담기</button>
				                    </div>
				                </td>
			                    <td>${bookList[i].viewCount}</td>
			                    <td>${bookList[i].reviewCount}</td>
			                </tr>
			            </c:forEach>
			        </c:when>
		        </c:choose>
	        </tbody>
	    </table>
	    
	  	<c:choose>
        	<c:when test="${not empty bookList}">
			    <!-- 페이징 -->
			    <div class="d-flex justify-content-center mt-4">
				    <nav aria-label="Page navigation">
				        <ul class="pagination">
				
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage - 1}">이전</a>
				                </li>
				            </c:if>
				
				            <c:forEach var="i" begin="${startPage}" end="${endPage}">
							    <li class="page-item ${i == currentPage ? 'active' : ''}">
							        <a class="page-link" href="?page=${i}">${i}</a>
							    </li>
							</c:forEach>
				
				            <c:if test="${currentPage < totalPages}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage + 1}">다음</a>
				                </li>
				            </c:if>
				        </ul>
				    </nav>
				</div>
			</c:when>
		</c:choose>
    </div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
