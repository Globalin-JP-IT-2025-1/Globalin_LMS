<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Bootstrap CSS & Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet" />

<style>
.form-control {
	background-color: #f0f6ff;
}

.login-btn {
	background-color: #0056b3;
	color: white;
	width: 100px;
}

.login-links a {
	margin-right: 15px;
	font-size: 14px;
	color: #666;
	text-decoration: none;
}

.notice-box {
	background-color: #f3f6f9;
	padding: 15px;
	margin-top: 30px;
	font-size: 14px;
	color: #555;
}
</style>


<div class="login-area text-center">
	<i class="bi bi-lock-fill icon"></i>

	<form class="text-start">
		<div class="input-group mb-3">
			<span class="input-group-text"><i class="bi bi-person-fill"></i></span>
			<input type="text" class="form-control" placeholder="아이디 입력">
		</div>

		<div class="input-group mb-4">
			<span class="input-group-text"><i
				class="bi bi-shield-lock-fill"></i></span> <input type="password"
				class="form-control" placeholder="비밀번호 입력">
		</div>

		<div class="text-end mb-3">
			<button type="submit" class="btn login-btn">로그인</button>
		</div>
	</form>

	<div class="login-links mb-3 text-start">
		<a href="#"><i class="bi bi-person"></i> 아이디찾기</a> <a href="#">비밀번호
			재발급</a> <a href="#">회원가입</a>
	</div>

	<div class="notice-box text-start">
		<div>・ 로그인 안 될 경우 한/영 키와 Caps Lock 키 확인</div>
		<div>・ 계속 문제 발생 시 관리자에게 문의 바랍니다</div>
	</div>
</div>





<!-- <form action="#" method="POST" onsubmit="return checkBlank(this)">
	<table id="loginForm">
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" max="30"> @ <select
				id="loginSelector">
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
			</select></td>
		</tr>

		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="password" max="30"></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form> -->