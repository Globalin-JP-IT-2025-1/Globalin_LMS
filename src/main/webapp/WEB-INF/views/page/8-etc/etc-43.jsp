<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 도서관 소개 > 도서 현황 -->

<style>
.etc_43 img {
	width: 80%;
}

.etc_43 .card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 5px 20px 20px 20px;
}

.etc_43 h5 {
	margin-top: 20px;
	font-size: 18px;
	color: #1b3a57;
}

</style>


<div class="etc_43">
	<div class="card m-3">
	  <h5><i class="bi bi-pie-chart"></i>&nbsp;글로벌인 도서관 도서 현황(권)</h5>
	  <hr class="border border-1 opacity-50">
	   <img src="${pageContext.request.contextPath}/resources/images/graph.png">
	</div>
</div>