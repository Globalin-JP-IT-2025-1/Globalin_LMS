<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
</style>
<!-- 로그인 폼 -->

<div class=""> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="testLogin()">로그인 테스트</button>
</div>

<div class="w-100">
	<div class="card shadow-sm w-60 pt-5">
		<div class="container d-flex flex-column justify-content-center align-items-center loginForm">
			<div class="mb-3 col-6 d-flex gap-2">
		        <div class="col-3 d-flex align-items-center">아이디</div>
		        <div class="input-group d-flex align-items-center">
		            <input class="form-control" type="text" id="usernameBox" value="" placeholder="아이디 입력" maxlength="20">
		        </div>
		    </div>
		    
		    <div class="mb-3 col-6 d-flex gap-2">
		    	<div class="col-3 d-flex align-items-center">비밀번호</div>
		        <div class="input-group d-flex align-items-center">
		            <input class="form-control" type="text" id="passwordBox" value="" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 password로 변경하기 -->
		        </div>
		    </div>
		    
		    <div class="mb-3 col-6 d-flex gap-2">
				<input class="form-check-input" type="checkbox" value="" id="autoLoginBox" checked>
				<label class="form-check-label" for="checkChecked">
				 	자동 로그인
				</label>
		    </div>
		
		    
		    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
		        <form action="/public/auto/login" method="post">
		        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        	<input type="hidden" name="username" id="username" value="" readonly><!-- 서버 송신용1 -->
		        	<input type="hidden" name="password" id="password" value="" readonly><!-- 서버 송신용2 -->
		        	<input type="hidden" name="autoLogin" id="autoLogin" value="1" disabled><!-- 서버 송신용3 : 자동 로그인 기능 구현 후 disabled 에서 readonly로 변경하기 -->
		        	<input class="mb-3 btn btn-primary" type="submit" value="로그인">
		        </form>
		    </div>
		</div>
	</div>
</div>


<script type="text/javascript">

function testLogin() {
	// 빈 값
	vailFormData();
	
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	var authLogin = document.getElementById("autoLogin").value;
	
	alert(" username: " + username + " password: " + password + " authLogin: " + authLogin);
	
	alert("로그인 요청데이터 테스트 완료");
}

// 빈 칸 검사
function vailFormData() {
	
	if (document.getElementById("usernameBox").value.trim() === "") {
	    alert("아이디가 비어있습니다");
	    document.getElementById("usernameBox").focus();
	    return;
	}
	
	if (document.getElementById("passwordBox").value.trim() === "") {
	    alert("비밀번호가 비어있습니다");
	    document.getElementById("passwordBox").focus();
	    return;
	}

}


// 서버 송신용 input 채우기
document.getElementById("usernameBox").addEventListener("blur", function () {
	document.getElementById("username").value = this.value;
});

document.getElementById("passwordBox").addEventListener("blur", function () {
	document.getElementById("password").value = this.value;
});

document.getElementById("autoLoginBox").addEventListener("change", function () {
    const isChecked = this.checked ? "1" : "0";

    // 값을 반영할 input 요소가 있다면 여기 넣어줘
    document.getElementById("autoLogin").value = isChecked;
});



</script>
