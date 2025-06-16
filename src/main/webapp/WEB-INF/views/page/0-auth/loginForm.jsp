<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

.card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 5px 20px 20px 20px; /* 위는 0, 나머지는 그대로 */
	width: 900px;
}

.login {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 60px;
  width: 1000px;
  padding: 50px 30px;
}

</style>
<div class="login">
<!-- 로그인 폼 -->
	<div class="card">

		<form action="/public/auth/login" method="post">
		
			<div id="loginForm">
				<div>id : <input type="text" name="username" id="username" placeholder="아이디 입력" maxlength="10"></div>
				<div>password : <input type="text" name="password" id="password" c></div> <!-- 테스트 후 password로 변경 -->
				<div><input type="checkbox" id="acceptAutoLogin"> 자동 로그인 </div>
				<div><input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />csrf token</div>
			</div>
			<div>
				<input type="submit" value="로그인">
			</div>			
		</form>
	</div>
	
</div>
