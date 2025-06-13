<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 비밀번호 재발급 요청 -->
<ul class="resetPasswordForm">
	<li>아이디 : <input type="text" id="username" maxlength="20"></li>
	<li>이메일 : <input type="text" id="email1" maxlength="30">@
		<select id="email2">
			<option value="test.com" selected>test.com</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
	</select></li>
	<li><input type="text" id="email"></li> <!-- 테스트 후 hidden으로 변경하기 -->
	<li>연락처 :
		<input type="text" id="mobile1" value="010" maxlength="3">-
		<input type="text" id="mobile2" value="0000" maxlength="4">-
		<input type="text" id="mobile3" value="0000" maxlength="4">
	</li>
	<li><input type="text" id="mobile" value="010-0000-0000"></li> <!-- 테스트 후 hidden으로 변경하기 -->
</ul>
<button onclick="resetPassword()">확인</button>

<script type="text/javascript">
	// 비밀번호 재발급 요청
	function resetPassword() {
		// 폼 데이터 가져오기
	    const guest = {
	        username: document.getElementById("username").value,
	        email: document.getElementById("email").value,
	        mobile: document.getElementById("mobile").value,
	    };
		
		Swal.fire({
	        title: "비밀번호 재발급",
	        text: "비밀번호 재발급 하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonColor: "#d33",
	        cancelButtonColor: "#3085d6",
	        confirmButtonText: "확인",
	        cancelButtonText: "취소"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            fetch(`/public/members/repass`, { 
	            	method: "POST",
	            	headers: { "Content-Type": "application/json" },
	                body: JSON.stringify(guest) // 객체를 JSON 문자열로 변환
	            })
	            .then(response => {
	                if (response.ok) {
	                    Swal.fire("비밀번호 재발급 완료", "비밀번호 재발급 완료하였습니다. 메일을 확인해주세요.", "success").then(() => {
	                    	location.href = "/public/auth/login"; // 로그인 폼으로 이동
	                    });
	                } else {
	                    Swal.fire("오류 발생", "비밀번호 재발급 실패했습니다.", "error");
	                }
	            })
	            .catch(error => {
	                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
	                console.error("Error:", error);
	            });
	        }
	    });
	}

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

		document.getElementById("mobile").value = value1 + "-" + value2 + "-"
				+ value3;
	}

	// 입력값 변경 시 자동 업데이트
	document.getElementById("mobile1").addEventListener("input", combineMobile);
	document.getElementById("mobile2").addEventListener("input", combineMobile);
	document.getElementById("mobile3").addEventListener("input", combineMobile);

</script>