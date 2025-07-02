<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이용 안내 > 회원가입 안내 -->

<style>
.etc_52 {
	width: 100%;
	padding-left: 20px;
	padding-bottom: 80px;
}

.etc_52 .card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 20px 20px 20px 30px; 
	margin-top: 40px;
	width: 90%;
}

/* 상단 알림 */
.etc_52_div1 {
	height: 60px;
}

/* 가입 방법 부분 */
.flow-container {
	padding: 20px 0;
	display: flex;
	align-items: center;
	margin-bottom: 40px;
}

.flow-card {
	background-color: var(--main-color);
	color: white;
	text-align: center;
	padding: 15px;
	border-radius: 10px;
	min-width: 200px;
	margin: 0 10px;
}

.flow-arrow {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 20px;
	font-size: 2em;
}

/* 전체 ul 부분 */
.etc_52_ul {
	margin-left: 30px;
	margin-bottom: 35px;
}

.etc_52_table {
	width: 90%;
	height: 170px;
	padding-left: 10px;
	border: 1.5px solid #333;
	border-collapse: collapse;
	margin-left: 35px;
    margin-bottom: 35px;
    margin-top: 20px;
}

.etc_52_table th, td{
	border: 1.5px solid #333;
	border-collapse: collapse;
}

.etc_52_table th{
	background-color: #f1f3f5;
}

.etc_52_table td{
	padding-left: 20px;
}

.etc_52_div2 {
	width: 100%;
	line-height: 40px;
	padding-left: 20px;
}
.etc_52_div2 .etc_52_div2_1 {
	width: 100%;
	line-height: 40px;
	padding-left: 30px;
}
</style>
<div class="etc_52">

	<div class="card">
		<div class="etc_52_div1">
			<p>
				<i class="bi bi-megaphone"></i>&ensp;<spring:message code="etc52.alert1"/>
			</p>
		</div>
		<div class="container flow-container">
			<div class="flow-card"><spring:message code="etc52.step1"/></div>
			<div class="flow-arrow"><i class="bi bi-arrow-right"></i></div>
			<div class="flow-card"><spring:message code="etc52.step2"/></div>
			<div class="flow-arrow"><i class="bi bi-arrow-right"></i></div>
			<div class="flow-card"><spring:message code="etc52.step3"/></div>
		</div>
	</div>
	<div class="card">
		<ul>
			<li><spring:message code="etc52.title1"/></li>
		</ul>
		<ul class="etc_52_ul">
			<li><spring:message code="etc52.li1"/></li>
			<li><spring:message code="etc52.li2" htmlEscape="false"/></li>
		</ul>
	</div>
	<div class="card">	
		<ul>		
			<li><spring:message code="etc52.title2"/></li>
		</ul>
		<ul class="etc_52_ul">
			<li><spring:message code="etc52.li3"/></li>
			<li><spring:message code="etc52.li4"/></li>
			<li><spring:message code="etc52.li5" htmlEscape="false"/></li>
		</ul>
	</div>
	<div class="card">
		<ul>		
			<li><spring:message code="etc52.title3"/></li>
		</ul>
		<ul class="etc_52_ul">
			<li><spring:message code="etc52.li6"/></li>
			<li><spring:message code="etc52.li7" htmlEscape="false"/></li>
			<li><spring:message code="etc52.li8"/></li>
		</ul>
	</div>
	<div class="card">
		<ul>		
			<li><spring:message code="etc52.title4"/></li>
		</ul>
		<table class="etc_52_table">
			<tr>
				<th><spring:message code="etc52.th1"/></th>
				<th><spring:message code="etc52.th2"/></th>
				<th><spring:message code="etc52.th3"/></th>
				<th><spring:message code="etc52.th4"/></th>
				<th><spring:message code="etc52.th5"/></th>
			</tr>
			<tr>
				<td rowspan="2"><spring:message code="etc52.td1"/></td>
				<td><spring:message code="etc52.td2"/></td>
				<td rowspan="2"><spring:message code="etc52.td3"/></td>
				<td rowspan="2"><spring:message code="etc52.td4"/></td>
				<td rowspan="2">
					<ul>
						<li><spring:message code="etc52.td5_1"/></li>
						<li><spring:message code="etc52.td5_2"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td><spring:message code="etc52.td6"/></td>
			</tr>
		</table>
	</div>
	<div class="etc_52_div2 card">
		<ul>
			<li><spring:message code="etc52.title5"/></li>
		</ul>
		<div class="etc_52_div2_1">
			<spring:message code="etc52.contact1" htmlEscape="false"/><br>
			<spring:message code="etc52.contact2" htmlEscape="false"/>
		</div>
	</div>
</div>
