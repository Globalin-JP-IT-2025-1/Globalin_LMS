<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 회원 가입 여부 확인 요청 -->

<div class=""> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="testMemberCheck()">아이디 찾기 테스트</button>
</div>

<div class="w-100">
	<div class="card shadow-sm w-60 pt-5">
		<div class="container d-flex flex-column justify-content-center align-items-center memberCheckForm">
		    <div class="mb-3 col-6 d-flex gap-2">
		    	<div class="col-3 d-flex align-items-center">이메일</div>
		        <div class="input-group d-flex align-items-center">
		            <input class="form-control" type="text" id="emailBox1" value="${emailParts[0]}" placeholder="이메일 입력" maxlength="30">
		            <i class="bi bi-at"></i>
		            <select id="emailBox2" class="form-select">
			            <option value="gmail.com" ${emailParts[0] eq 'gmail.com' ? 'selected' : ''}>gmail.com</option>
			            <option value="naver.com" ${emailParts[0] eq 'naver.com' ? 'selected' : ''}>naver.com</option>
			            <option value="test.com" ${emailParts[0] eq 'test.com' ? 'selected' : ''}>test.com</option>
			        </select>
		        </div>
		    </div>
		    
		    <div class="mb-3 col-6 d-flex gap-2">
		    	<div class="col-3 d-flex align-items-center">전화번호</div>
		        <div class="input-group d-flex align-items-center">
		            <input class="form-control" type="text" id="mobileBox1" value="${mobileParts[0]}" maxlength="3">-
					<input class="form-control" type="text" id="mobileBox2" value="${mobileParts[1]}" maxlength="4">-
					<input class="form-control" type="text" id="mobileBox3" value="${mobileParts[2]}" maxlength="4">
		        </div>
		    </div>
		    
		    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
		        <form action="/public/members/check" method="post">
		        	<input class="d-none" type="text" name="email" id="email" value="" readonly><!-- 서버 송신용1 -->
		        	<input class="d-none" type="text" name="mobile" id="mobile" value="" readonly><!-- 서버 송신용2 -->
		        	<input class="mb-3 btn btn-primary" type="submit" value="아이디 찾기">
		        </form>
		    </div>
		</div>
	</div>
</div>

<script type="text/javascript">
function testMemberCheck() {
	// 빈 값
	vailFormData();
	
	var email = document.getElementById("email").value;
	var mobile = document.getElementById("mobile").value;
	
	alert(" email: " + email + ", mobile: " + mobile);
	
	alert("아이디 찾기 요청데이터 테스트 완료");

}

// 빈 칸 검사
function vailFormData() {
	
	if (document.getElementById("emailBox1").value.trim() === "" ) {
	    alert("이메일이 비어있습니다");
	    document.getElementById("emailBox1").focus();
	    return;
	}
	
	if (document.getElementById("mobileBox1").value.trim() === "") {
	    alert("전화번호가 비어있습니다");
	    document.getElementById("mobileBox1").focus();
	    return;
	}
	
	if (document.getElementById("mobileBox2").value.trim() === "") {
	    alert("전화번호가 비어있습니다");
	    document.getElementById("mobileBox2").focus();
	    return;
	}
	
	if (document.getElementById("mobileBox3").value.trim() === "") {
	    alert("전화번호가 비어있습니다");
	    document.getElementById("mobileBox3").focus();
	    return;
	}

}

//이메일 합치기 + 값 검사
document.getElementById("emailBox1").addEventListener("input", function() {
	let value1 = this.value;

    // 특수문자 포함 여부 확인 (영문, 숫자만 허용)
    if (/[^a-zA-Z0-9]/.test(value1)) {
        alert("이메일은 영문과 숫자만 사용할 수 있습니다");
        document.getElementById("emailBox1").value = "";
    }
    
    document.getElementById("email").value = value1 + "@" + document.getElementById("emailBox2").value;
});

document.getElementById("emailBox2").addEventListener("change", function() {
    document.getElementById("email").value = document.getElementById("emailBox1").value + "@" + this.value;
});

// 연락처 합치기 + 값 검사
document.getElementById("mobileBox1").addEventListener("input", combineMobile);
document.getElementById("mobileBox2").addEventListener("input", combineMobile);
document.getElementById("mobileBox3").addEventListener("input", combineMobile);

function combineMobile() {
    let originalValue1 = document.getElementById("mobileBox1").value;
    let originalValue2 = document.getElementById("mobileBox2").value;
    let originalValue3 = document.getElementById("mobileBox3").value;

    if (/[^0-9]/.test(originalValue1)) {
        alert("연락처는 숫자만 사용할 수 있습니다");
        document.getElementById("mobileBox1").value = "010";
    }

    if (originalValue2 != "" && /[^0-9]/.test(originalValue2)) {
        alert("연락처는 숫자만 사용할 수 있습니다");
        document.getElementById("mobileBox2").value = "";
    }

    if (originalValue3 != "" && /[^0-9]/.test(originalValue3)) {
        alert("연락처는 숫자만 사용할 수 있습니다");
        document.getElementById("mobileBox3").value = "";
    }

    document.getElementById("mobile").value = originalValue1 + "-" + originalValue2 + "-" + originalValue3;
}


</script>