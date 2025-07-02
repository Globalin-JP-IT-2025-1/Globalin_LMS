<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이용 안내 > 도서 이용 안내 -->

<style>
.etc_53 {
	width:100%;
	padding-left: 20px;
	padding-bottom: 100px;
	padding-top: 5px;
}

.etc_53 .card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 25px 10px 15px 40px;
    width: 100%;
    margin-bottom: 40px;
    margin-top: 35px;
}
.etc_53 .card2 {
	background-color: #fff;
	border: 0.5px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 30px 10px 40px 40px;
    width: 100%;
}

.etc_t3_div >ul >li{
	font-size: 1.2em;
    margin-left: -10px;
}


/* 상단 테이블 */
.etc_53_table1 {
	border: 1.8px solid #333;
	border-collapse: collapse;
	width: 95%;
	margin-bottom: 30px; 
	
}


.etc_53_table1 th{
	border: 1.8px solid #333;
	background-color: #f1f3f5;
	margin-right: 20px;
	color: var(--main-color);
	padding: 15px 0 15px 15px;
}

.etc_53_table1 td{
	border: 1.8px solid #333;
	padding: 20px 0 10px 15px;
}

.etc_53_table1 .e53_th1 {
	background-color: #f1f3f5;;
}

.etc_53_table1 .e53_th2 {
	background-color: #f1f3f5;
}

.etc_53_table1 .e53_th3 {
	width: 175px;
}

.etc_53_table1 .e53_td1 {
	height: 60px;
}

.etc_53_table1 .e53_td2 {
	padding-top: 15px;
}


/* 하단 테이블 */

.etc_53_table2 {
	border: 1.8px solid #333;
	border-collapse: collapse;
	width: 95%;
}

.etc_53_table2 th{
	border: 1.8px solid #333;
	background-color: #f1f3f5;
	padding: 15px 0 15px 15px;
	
}

.etc_53_table2 td{
	border: 1.8px solid #333;
	padding: 20px 0 10px 15px;
}

.etc_53_table2 .e53_th1 {
	background-color: #f1f3f5;
}

.etc_53_table2 .e53_th2 {
	background-color: #f1f3f5;
}

.e53_td2_li {
	margin-left: 30px;
}

.etc_53_table2 .e53_th3 {
	width: 175px;
}
</style>

<div class="etc_53">
	<div class="card">
		<div class="etc_t3_div">
			<ul>
				<li><spring:message code="etc53.section1"/></li>
			</ul>
		</div>
		<table class="etc_53_table1">
			<tr>
				<th class="e53_th1"><spring:message code="etc53.th.type"/></th>
				<th class="e53_th2"><spring:message code="etc53.th.content"/></th>
			</tr>
			<tr>
				<th class="e53_th3"><spring:message code="etc53.th.target"/></th>
				<td class="e53_td1">
					<ul>
						<li><spring:message code="etc53.td1.li1"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.method"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td2.li1"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.count_period"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td3.li1"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.return"/></th>
				<td class="e53_td2">
					&nbsp;&nbsp;<spring:message code="etc53.td4.txt1"/><ul>
						<li><spring:message code="etc53.td4.li1"/></li>
						<li class="e53_td2_li"><spring:message code="etc53.td4.li2"/></li>
						<li class="e53_td2_li"><spring:message code="etc53.td4.li3"/></li>
						<li class="e53_td2_li"><spring:message code="etc53.td4.li4"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.limit"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td5.li1"/></li>
						<li><spring:message code="etc53.td5.li2"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.lost"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td6.li1" htmlEscape="false"/></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="card2">
		<div class="etc_t3_div">
			<ul>
				<li><spring:message code="etc53.section2"/></li>
			</ul>
		</div>
		<table class="etc_53_table2">
			<tr>
				<th class="e53_th1"><spring:message code="etc53.th.type"/></th>
				<th class="e53_th2"><spring:message code="etc53.th.content"/></th>
			</tr>
			<tr>
				<th class="e53_th3"><spring:message code="etc53.th.use_guide"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td7.li1" htmlEscape="false"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.reserve_target"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td8.li1"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.reserve_method"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td9.li1"/></li>
						<li><spring:message code="etc53.td9.li2"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><spring:message code="etc53.th.caution"/></th>
				<td>
					<ul>
						<li><spring:message code="etc53.td10.li1"/></li>
						<li><spring:message code="etc53.td10.li2"/></li>
						<li><spring:message code="etc53.td10.li3"/></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</div>