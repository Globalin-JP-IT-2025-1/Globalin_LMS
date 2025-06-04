<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- <form action="/members" method="POST" onsubmit="return checkBlank(this)"> -->
<form action="/members" method="POST">
	<ul class="regForm">
		<li>members_id : <input type="text" value="DB 자동 생성" disabled></li>
		<li>status : <input type="text" value="입력 불가능" disabled></li>
		<li>card_num : <input type="text" value="도서관 방문 요망" disabled></li>
		<li>email : 
			<input type="email" id="email1" maxlength="30">@
			<select id="email2">
				<option value="test.com" selected>test.com</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
			</select>
			<a href="#">중복확인</a>
		</li>
		<li><input type="text" id="email" value="email"></li>  <!-- 테스트 후 hidden으로 변경하기 -->
		<li>password : <input type="password" id="password" placeholder="비밀번호 입력" maxlength="20"></li>
		<li>password 확인 : <input type="password" id="confirmPassword" placeholder="비밀번호 입력" maxlength="20"><span id="pwMessage"></span></li>
		<li>name : <input type="text" value="name" maxlength="30"></li>
		<li>mobile : 
			<input type="text" id="mobile1" value="010" maxlength="3">-
			<input type="text" id="mobile2" value="0000" maxlength="4">-
			<input type="text" id="mobile3" value="0000" maxlength="4">
		</li>
		<li><input type="text" id="mobile"></li> <!-- 테스트 후 hidden으로 변경하기 -->
		<li>zipcode : <input type="text" id="zipcode" value="자동 입력" readonly></li>
		<li>address : <input type="text" id="address" value="자동 입력" readonly><a href="#">주소찾기</a></li>
		<li>join_date : <input type="text" value="java 자동 생성" disabled></li>
		<li>leave_date : <input type="text" value="null" disabled></li>
	</ul>
	<input type="submit" value="회원가입">
</form>

<script>
// 이메일 합치기
function combineEmail() {
    let value1 = document.getElementById("email1").value;
    let value2 = document.getElementById("email2").value;
    document.getElementById("email").value = value1 + "@" + value2;

    console.log(document.getElementById("email").value); // 예: "test@naver.com"
}

// 입력값 변경 시 자동 업데이트
document.getElementById("email1").addEventListener("input", combineEmail);
document.getElementById("email2").addEventListener("change", combineEmail);

// 연락처 합치기
function combineMobile() {
    let value1 = document.getElementById("mobile1").value;
    let value2 = document.getElementById("mobile2").value;
    let value3 = document.getElementById("mobile3").value;
    
    document.getElementById("mobile").value = value1 + "-" + value2 + "-" + value3;
}

// 입력값 변경 시 자동 업데이트
document.getElementById("mobile1").addEventListener("input", combineMobile);
document.getElementById("mobile2").addEventListener("input", combineMobile);
document.getElementById("mobile3").addEventListener("input", combineMobile);

// 비밀번호 일치하는지 확인하기
document.getElementById("confirmPassword").addEventListener("input", function () {
    let password = document.getElementById("password").value;
    let confirmPassword = this.value;
    let message = document.getElementById("pwMessage");

    if (password === confirmPassword) {
        message.textContent = "비밀번호가 일치합니다";
        message.style.color = "green";
    } else {
        message.textContent = "비밀번호가 일치하지 않습니다";
        message.style.color = "red";
    }
});
</script>
