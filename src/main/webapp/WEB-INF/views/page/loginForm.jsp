<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form action="#" method="POST" onsubmit="return checkBlank(this)">
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
</form>