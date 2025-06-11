<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
				<li>대출/반납 안내</li>
			</ul>
		</div>
		<table class="etc_53_table1">
			<tr>
				<th class="e53_th1">구분</th>
				<th class="e53_th2">내용</th>
			</tr>
			
			<tr>
				<th class="e53_th3">대상</th>
				<td class="e53_td1">
					<ul>
						<li>글로벌인 도서관 정회원(회원증 발급자)</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>대출방법</th>
				<td>
					<ul>
						<li>각 자료열람실에서 원하는 자료를 찾아 대출반납 데스크에 회원증 또는 모바일회원증 제시 후 대출.</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>권수/기간</th>
				<td>
					<ul>
						<li>1인당 5권이며 대출기간은14일간(연장 1회 가능)</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>반납 방법</th>
				<td class="e53_td2">&nbsp;&nbsp;도서관 운영시간 내에는 대출한 데스크에서 반납하실 수 있습니다.
					<ul>
						<li>야외 도서반납함 이용 안내</li>
						<li class="e53_td2_li">도서관 휴관(매주 월요일, 법정 공휴일) 또는 자료실 운영이 끝났을 때 이용하시면 됩니다.</li>
						<li class="e53_td2_li">반납된 자료는 다음 업무 개시일에 처리됩니다.</li>
						<li class="e53_td2_li">반납 후에는 자료실(정상 근무시간)에 전화 등으로 확인바랍니다.</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>대출 제한</th>
				<td>
					<ul>
						<li>대출도서를 연체하였을 경우, 연체일 수 만큼 대출정지.</li>
						<li>반납하신 도서는 당일 재대출 불가.</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>도서 분실</th>
				<td>
					<ul>
						<li>자료를 잃어버리거나 훼손하면 동일한 자료로 변상하여야 하며,<br>
							동일한 자료로 변상이 불가능할 시 자료실 담당자에게 문의하시길 바랍니다.</li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="card2">
		<div class="etc_t3_div">
			<ul>
				<li>도서 예약 안내</li>
			</ul>
		</div>
		<table class="etc_53_table2">
		<tr>
				<th class="e53_th1">구분</th>
				<th class="e53_th2">내용</th>
			</tr>
			
			<tr>
				<th class="e53_th3">이용안내</th>
				<td>
				
					<ul>
						<li>
							필요한 자료가 대출되어 이용이 불가능할 때 도서대출 예약을 이용하시면<br>
							해당 도서가 반납되는 즉시 예약 순서에 따라 우선적으로 자료를 보실 수 있습니다.
						</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>예약 대상 도서</th>
				<td>
					<ul>
						<li>현재 대출중인 도서(대출 가능한 도서는 예약 불가)</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>예약방법</th>
				<td>
					<ul>
						<li>홈페이지 로그인 후 예약가능한 자료를 찾은 후 도서예약신청 버튼을 눌러서 예약합니다.</li>
						<li>예약은 1회 최대 3권까지만 가능합니다.</li>
					</ul>
				</td>
			</tr>
			
			<tr>
				<th>유의사항</th>
				<td>
					<ul>
						<li>반납과 동시에 예약대출 안내 SMS가 발송됩니다.</li>
						<li>반납된 도서는 3일간 별도로 비치하며 3일이 지나면 예약이 취소됩니다.</li>
						<li>예약하고자 하는 도서를 이미 세 명이상 예약했을 경우에는 예약이 불가능합니다.</li>
					</ul>
				</td>
			</tr>
			
		</table>
	</div>
</div>