<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
@import "bootstrap/scss/";
</style>

<!-- 회원 등록 요청 -->
<ul class="regForm">
	<li>members_id : <input type="text" value="DB 자동 생성" disabled></li><!-- 테스트 후 hidden로 변경하기 -->
	<li>status : <input type="text" value="입력 불가능" disabled></li>
	<li>card_num : <input type="text" value="도서관 방문 요망" disabled></li>
	<li>id : <input type="text" id="username" placeholder="아이디 입력" maxlength="20"><a href="#">중복확인</a></li>
	<li>password : <input type="text" id="password" placeholder="비밀번호 입력" maxlength="20"></li><!-- 테스트 후 password로 변경하기 -->
	<li>password 확인 : 
		<input type="text" id="confirmPassword" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 hidden로 변경하기 -->
		<span id="pwMessage"></span>
	</li>
	<li>name : <input type="text" id="name" maxlength="30"></li>
	<li>email : <input type="text" id="email1" maxlength="30">@
		<select id="email2">
			<option value="test.com" selected>test.com</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
		</select>
		<a href="#">중복확인</a><br>
		<input type="text" id="email"><!-- 테스트 후 hidden으로 변경하기 -->
	</li> 
	<li>mobile :
		<input type="text" id="mobile1" value="010" maxlength="3">-
		<input type="text" id="mobile2" value="0000" maxlength="4">-
		<input type="text" id="mobile3" value="0000" maxlength="4"><br>
		<input type="text" id="mobile"><!-- 테스트 후 hidden으로 변경하기 -->
	</li> 
	<!-- <li>zipcode : <input type="text" id="zipcode" value="자동 입력" maxlength="10" readonly></li>
	<li>address : <input type="text" id="address" value="자동 입력" maxlength="100" readonly><a href="#">주소찾기</a></li> -->
	<li>zipcode : <input type="text" name="zipcode" id="zipcode" value="자동 입력" maxlength="10"></li>
	<li>address : <input type="text" name="address" id="address" value="자동 입력" maxlength="100"><a href="#">주소찾기</a></li>
</ul>
<button onclick="insertMember()">회원가입</button>


<script>

	// 회원가입 요청
	function insertMember() {
		// 폼 데이터 가져오기
	    const member = {
	        username: document.getElementById("username").value,
	        password: document.getElementById("password").value,
	        name: document.getElementById("name").value,
	        email: document.getElementById("email").value,
	        mobile: document.getElementById("mobile").value,
	        zipcode: document.getElementById("zipcode").value,
	        address: document.getElementById("address").value
	    };
		
		Swal.fire({
	        title: "회원 가입",
	        text: "회원 가입 하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonColor: "#d33",
	        cancelButtonColor: "#3085d6",
	        confirmButtonText: "확인",
	        cancelButtonText: "취소"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            fetch(`/public/members`, { 
	            	method: "POST",
	            	headers: { "Content-Type": "application/json" },
	                body: JSON.stringify(member) // 객체를 JSON 문자열로 변환
	            })
	            .then(response => {
	                if (response.ok) {
	                    Swal.fire("가입 완료", "회원 가입을 성공 하였습니다.", "success")
	                    .then(() => {
	                    	location.href = "/"; // 홈으로
	                    });
	                } else {
	                    Swal.fire("오류 발생", "회원 정보 수정 실패했습니다.", "error");
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

	// 비밀번호 일치하는지 확인하기
	document.getElementById("confirmPassword").addEventListener("input",
			function() {
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
