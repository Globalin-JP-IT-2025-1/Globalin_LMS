<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
</style>

<!-- 본문 -->
<div class="m_main_area">
	<!-- 로그인 입력 폼 -->
	<div class="container mt-5" style="max-width: 500px;">
		<form>
			<div class="mb-3 row align-items-center">
				<label class="col-sm-3 col-form-label fw-bold text-end">이메일</label>
				<div class="col-sm-4">
					<input type="text" class="form-control border border-info"
						placeholder="아이디" name="emailId" required>
				</div>
				<div class="col-sm-1 text-center">@</div>
				<div class="col-sm-4">
					<select class="form-select border border-info" name="emailDomain"
						required>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="gmail.com">yahoo.co.jp</option>
					</select>
				</div>
			</div>

			<!-- 비밀번호 입력 -->
			<div class="mb-3 row align-items-center">
				<label class="col-sm-3 col-form-label fw-bold text-end">비밀번호</label>
				<div class="col-sm-9">
					<input type="password" class="form-control border border-info"
						placeholder="비밀번호" name="password" required>
				</div>
			</div>

			<!-- 로그인 버튼 -->
			<div class="text-center mt-4">
				<button type="submit" class="btn text-white px-5 py-2 fw-bold"
					style="background-color: var(- -main-color); border-radius: 10px;">
					로그인</button>
			</div>
		</form>
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