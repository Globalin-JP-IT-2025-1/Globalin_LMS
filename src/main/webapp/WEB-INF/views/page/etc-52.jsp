<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 이용 안내 > 회원가입 안내 -->

<style>
.etc_52 {
	width: 100%;
	padding-left: 20px;
	padding-bottom: 80px;
	padding-top: 10px;	
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
	padding-left: 10px;
	border: 1.5px solid #333;
	border-collapse: collapse;
	margin-left: 35px;
    margin-bottom: 35px;
    margin-top: 20px;
	height: 170px;
}

.etc_52_table th, td{
	border: 1.5px solid #333;
	border-collapse: collapse;
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

	<div>
		<div class="etc_52_div1">
			<p>
				<i class="bi bi-megaphone"></i>&ensp;홈페이지 회원가입 후, 도서관 방문하여
				정회원으로 승급된 이후 도서 대출 가능합니다.
			</p>
		</div>
		<div class="container flow-container">
			<div class="flow-card">홈페이지 기입</div>
			<div class="flow-arrow"><i class="bi bi-arrow-right"></i></div>
			<div class="flow-card">도서관 방문</div>
			<div class="flow-arrow"><i class="bi bi-arrow-right"></i></div>
			<div class="flow-card">회원카드 발급</div>
		</div>
		<div>
			<ul>
				<li>회원가입 방법</li>
			</ul>
				<ul class="etc_52_ul">
					<li>글로벌인 도서관 홈페이지 회원 가입(준회원) : 이메일 인증 필수</li>
					<li>도서관 방문하여 회원카드 발급 및 정회원 승급<br>
					※ 정회원 승급(회원카드 발급) 이후 도서 대출 및 자료실 이용 가능<br>
					※ 개인정보보호법 시행에 따라 주민등록번호를 이용한 실명인증 중단(2014.08.01)
					</li>
				</ul>
			<ul>		
				<li>회원가입 대상자</li>
			</ul>
			<ul class="etc_52_ul">
				<li>현재 서울시민 및 서울내 학교, 직장에 속한 대한민국 국민</li>
				<li>출입국관리법」제31조에 따라 외국인등록을 한 사람</li>
				<li>만14세 미만 미성년자 : 법정대리인(보호자)의 본인확인과 동의 절차를 거쳐 홈페이지 회원 가입<br>
				※ 글로벌인 도서관 홈페이지에서는 표준개인정보보호지침(안전행정부 2011.09)에 따라<br>
				홈페이지 회원가입일 또는 개인정보 제공 동의일로부터 2년이 경과할 때마다 개인정보 제공에 대한 재동의를 받습니다.
				</li>
			</ul>
			
			<ul>		
				<li>회원 준수사항</li>
			</ul>
			<ul class="etc_52_ul">
				<li>회원카드는 타인에게 양도 또는 대리 사용, 대리 발급 불가합니다(적발시, 회원 탈퇴)</li>
				<li>주소, 연락처 등 인적사항이 변경된 경우에는, 영등포구 통합 홈페이지에 로그인하여, 본인이 직접 수정하며,<br>
					정보를 변경하지 않음에 따라 발생한 불이익의 책임은 회원 본인에게 있습니다.
				</li>
				<li>비밀번호는 노출되지 않도록 주의를 당부바라며 반드시 주기적인 변경을 부탁드립니다</li>
			</ul>
			
			<ul>		
				<li>회원가입 및 회원카드 발급 시간</li>
			</ul>
			<table class="etc_52_table">
				<tr>
					<th>구분</th>
					<th>요일</th>
					<th>시간</th>
					<th>접수장소</th>
					<th>기타사항</th>
				</tr>
				<tr>
					<td rowspan="2">구립도서관</td>
					<td>평일(화~금)</td>
					<td rowspan="2">도서관운영시간</td>
					<td rowspan="2">통합대출대</td>
					<td rowspan="2">
						<ul>
							<li>홈페이지 회원 가입 필수</li>
							<li>도서관 휴관일 : 매주 월요일</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>주말(토,일)</td>
				</tr>
			</table>
			
			<div class="etc_52_div2">
				☎ 전화문의<br>
				<div class="etc_52_div2_1">
					신길도서관 : ☎ 02-2165-7700(대표번호)<br>
					대림도서관 : ☎ 02-828-3702~03(통합대출대)
				</div>
			</div>
		</div>
	</div>
</div>