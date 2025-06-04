<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
</style>

<form action="/login" method="POST" onsubmit="return checkBlank(this)">
	<ul id="loginForm">
		<li>email : 
			<input type="email" id="email1" maxlength="30">@
			<select id="email2">
				<option value="test.com" selected>test.com</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
			</select>
		</li>
		<li><input type="text" id="email" value="email"></li>  <!-- 테스트 후 hidden으로 변경하기 -->
		<li>password : <input type="password" id="password" placeholder="비밀번호 입력" maxlength="20"></li>

	</ul>
</form>

<script>
function combineEmail() {
    let value1 = document.getElementById("email1").value;
    let value2 = document.getElementById("email2").value;
    document.getElementById("email").value = value1 + "@" + value2;

    console.log(document.getElementById("email").value); // 예: "test@naver.com"
}

// 입력값 변경 시 자동 업데이트
document.getElementById("email1").addEventListener("input", combineEmail);
document.getElementById("email2").addEventListener("change", combineEmail);
</script>