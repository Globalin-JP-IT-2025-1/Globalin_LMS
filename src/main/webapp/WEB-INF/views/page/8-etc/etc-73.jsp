<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 홈페이지 이용 안내 > 개인정보처리방침 -->

<style>
.etc_73 {
	/* width: 300px; */
	height: 566px;
	overflow: auto; /* 또는 overflow-y: scroll; */
	border: 1px solid #ccc;
	font-family: '맑은 고딕', sans-serif;
	line-height: 1.8;
	padding: 40px;
	/* max-width: 960px; */
	margin: auto;
	background-color: #ffffff;
	color: #333;
	margin-bottom: 80px;
	
}

.etc_73 table {
	width: 100%;
	border-collapse: collapse;
	margin: 24px 0;
}

.etc_73 th, td {
	border: 1px solid #aaa;
	padding: 8px;
	text-align: left;
}

.etc_73 th {
	background-color: #f2f2f2;
}
</style>

<div class="etc_73">
  <spring:message code="etc73.privacy_policy" htmlEscape="false"/>
</div>
