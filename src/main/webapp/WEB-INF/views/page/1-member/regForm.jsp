<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="key" value="${apiKey}" />

<!-- Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=${key}&libraries=places"></script>

<style>
    /* 주소 찾기 모달창 */
    #addressModal {
        z-index: 10000 !important;
    }

    /* 구글 맵 검색결과 */
    .pac-container { 
        z-index: 10001 !important;
    }
</style>

<!-- 회원 등록 요청 -->
<div class=""> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="vailRequestData()">유효성 검사</button>
	<button onclick="testInsertMember()">회원가입 테스트</button>
</div>

<div class="container d-flex flex-column justify-content-center align-items-center regForm">
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">아이디</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="usernameBox" value="" placeholder="아이디 입력" maxlength="20">
            <button class="btn btn-primary">중복확인</button>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">비밀번호</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="passwordBox" value="" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 password로 변경하기 -->
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">비밀번호 확인</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="confirmPasswordBox" value="" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 password로 변경하기 -->
        </div>
    </div>
	<div class="mb-3 col-6 d-flex justify-content-end gap-2">
		<div class="col-1 d-none">
			<input class="form-control" type="text" id="pwMatchStatus"><!-- 테스트 시 d-none 해제 -->
		</div>
		<div class="col-5 d-flex flex-row-reverse" id="pwMessage"></div>
	</div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">이름</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="nameBox" placeholder="이름 입력" maxlength="30">
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">이메일</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="emailBox1" placeholder="이메일 입력" maxlength="30">
            <i class="bi bi-at"></i>
            <select id="emailBox2" class="form-select">
	            <option value="gmail.com" selected>gmail.com</option>
	            <option value="naver.com">naver.com</option>
	            <option value="test.com">test.com</option>
	        </select>
	        <button class="btn btn-primary">중복확인</button>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">전화번호</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="mobileBox1" value="010" maxlength="3">-
			<input class="form-control" type="text" id="mobileBox2" value="" maxlength="4">-
			<input class="form-control" type="text" id="mobileBox3" value="" maxlength="4">
        </div>
    </div>

	<!-- 주소 파트 -->
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">주소</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="addressBox" placeholder="주소 자동 입력" readonly>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal">주소찾기</button>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">상세 주소</div>
        <div class="input-group d-flex align-items-center">
            <input class="form-control" type="text" id="addressDetailBox" placeholder="상세 주소 입력">
        </div>
    </div>

    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">우편번호</div>
        <div class="input-group d-flex align-items-center">
        	<input class="form-control" type="text" id="zipcodeBox" placeholder="우편번호 자동 입력">
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
        <button class="mb-3 btn btn-secondary" onclick="initForm()">초기화</button>
        <form action="/public/members" method="post">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        	<input class="d-none" type="text" name="username" id="username" value="" readonly><!-- 서버 송신용1 -->
        	<input class="d-none" type="text" name="password" id="password" value="" readonly><!-- 서버 송신용2 -->
        	<input class="d-none" type="text" name="name" id="name" value="" readonly><!-- 서버 송신용3 -->
        	<input class="d-none" type="text" name="email" id="email" value="" readonly><!-- 서버 송신용4 -->
        	<input class="d-none" type="text" name="mobile" id="mobile" value="" readonly><!-- 서버 송신용5 -->
        	<input class="d-none" type="text" name="address" id="address" value="" readonly><!-- 서버 송신용6 -->
        	<input class="d-none" type="text" name="addressDetail" id="addressDetail" value="" readonly><!-- 서버 송신용7 -->
        	<input class="d-none" type="text" name="zipcode" id="zipcode" value="" readonly><!-- 서버 송신용8 -->
        	<input class="mb-3 btn btn-primary" type="submit" value="회원가입">
        </form>
    </div>
</div>

<!-- Bootstrap 모달창 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">주소 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input id="modal-search" class="form-control mb-2" placeholder="주소를 검색해주세요">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="getAddressBtn" data-bs-dismiss="modal">주소 가져오기</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

function testInsertMember() {
	// 빈 값, 비밀번호 일치 여부(pwMatchStatus=0)
	vailFormData();
	// 비밀번호 자릿수 검사(8자 이상)
	vailRequestData();
	
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	var mobile = document.getElementById("mobile").value;
	var zipcode = document.getElementById("zipcode").value;
	var address = document.getElementById("address").value;
	var addressDetail = document.getElementById("addressDetail").value;
	
	alert(" username: " + username + " password: " + password 
			+ " name: " + name + " email: " + email + " mobile: " + mobile
			+ " zipcode: " + zipcode + " address: " + address + " addressDetail: " + addressDetail);
	
	alert("회원가입 요청데이터 테스트 완료");
}

// 빈 칸 검사
function vailFormData() {
	
	if (document.getElementById("username").value.trim() === "" ||
		document.getElementById("usernameBox").value.trim() === "") {
	    alert("아이디가 비어있습니다");
	    document.getElementById("usernameBox").focus();
	    return;
	}
	
	if (document.getElementById("password").value.trim() === "" || 
		document.getElementById("passwordBox").value.trim() === "") {
	    alert("비밀번호가 비어있습니다");
	    document.getElementById("passwordBox").focus();
	    return;
	}
	
	if (document.getElementById("confirmPasswordBox").value.trim() === "") {
	    alert("비밀번호 확인이 비어있습니다");
	    document.getElementById("confirmPasswordBox").focus();
	    return;
	}
	
	if (document.getElementById("name").value.trim() === "" ||
		document.getElementById("nameBox").value.trim() === "") {
	    alert("이름이 비어있습니다");
	    document.getElementById("nameBox").focus();
	    return;
	}
	
	if (document.getElementById("email").value.trim() === "" ||
		document.getElementById("emailBox1").value.trim() === "" ) {
	    alert("이메일이 비어있습니다");
	    document.getElementById("emailBox1").focus();
	    return;
	}
	
	if (document.getElementById("mobile").value.trim() === "" ||
		document.getElementById("mobileBox1").value.trim() === "") {
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
	
	if (document.getElementById("zipcode").value.trim() === "" ||
		document.getElementById("zipcodeBox").value.trim() === "") {
	    alert("우편번호가 비어있습니다");
	    document.getElementById("zipcodeBox").focus();
	    return;
	}
	
	if (document.getElementById("address").value.trim() === "" ||
		document.getElementById("addressBox").value.trim() === "") {
	    alert("주소가 비어있습니다");
	    document.getElementById("addressBox").focus();
	    return;
	}
	
	if (document.getElementById("addressDetail").value.trim() === "" ||
		document.getElementById("addressDetailBox").value.trim() === "") {
	    alert("상세 주소가 비어있습니다");
	    document.getElementById("addressDetailBox").focus();
	    return;
	}
    
	// 비밀번호 일치 여부
	if (document.getElementById("pwMatchStatus").value < 0) {
	    alert("비밀번호가 일치하지 않습니다");
	    document.getElementById("passwordBox").focus();
	    return;
	}
    
}

// 요청 데이터 값 검사
function vailRequestData() {
	// 자릿수 검사 : 8자 이상
	if (!/.{8,}/.test(document.getElementById("password").value)) {
	    alert("비밀번호는 8자 이상이어야 합니다.");
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

document.getElementById("nameBox").addEventListener("blur", function () {
    document.getElementById("name").value = this.value;
});

document.getElementById("zipcodeBox").addEventListener("blur", function () {
    document.getElementById("zipcode").value = this.value;
});

document.getElementById("addressBox").addEventListener("blur", function () {
    document.getElementById("address").value = this.value;
});

document.getElementById("addressDetailBox").addEventListener("blur", function () {
    document.getElementById("addressDetail").value = this.value;
});


// 이메일 합치기 + 값 검사
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

// 아이디(username) 값 검사
document.getElementById("usernameBox").addEventListener("input", function () {
    // 특수문자 포함 여부 확인 (영문, 숫자만 허용)
    if (/[^a-zA-Z0-9]/.test(this.value)) {
        alert("아이디는 영문과 숫자만 사용할 수 있습니다");
        this.value = "";
    }
});

// 비밀번호 일치 확인
document.getElementById("passwordBox").addEventListener("input", vailPassword);
document.getElementById("confirmPasswordBox").addEventListener("input", vailPassword);

function vailPassword() {
	let password = document.getElementById("passwordBox").value.trim();
    let confirmPassword = document.getElementById("confirmPasswordBox").value.trim();
    let message = document.getElementById("pwMessage");
    let status = document.getElementById("pwMatchStatus");

    if (password === "" && confirmPassword === "") {
        message.textContent = "비밀번호를 입력바랍니다";
        message.style.color = "";
        status.value = "-2";
    } else if (password === "" && confirmPassword !== "") {
        message.textContent = "비밀번호를 입력바랍니다";
        message.style.color = "";
        status.value = "-3";
    } else if (password !== "" && confirmPassword === "") {
        message.textContent = "비밀번호 확인을 입력바랍니다";
        message.style.color = "";
        status.value = "-4";
    } else if (password === confirmPassword) {
        message.textContent = "비밀번호가 일치합니다!";
        message.style.color = "green";
        status.value = "0";
    } else if (password !== confirmPassword) {
        message.textContent = "비밀번호가 일치하지 않습니다";
        message.style.color = "red";
        status.value = "-1";
    }
    
}

// 우편번호(zipcode) 값 검사
document.getElementById("zipcodeBox").addEventListener("input", function () {
    // 특수문자 포함 여부 확인 (숫자, -만 허용)
    if (/[^0-9-]/.test(this.value)) {
        alert("우편번호는 숫자와 하이픈(-)만 입력할 수 있습니다");
        this.value = "";
    }
});

// 주소 검색 자동완성
function initAutocomplete() {
    var input = document.getElementById('modal-search');
    var autocomplete = new google.maps.places.Autocomplete(input);

    autocomplete.addListener('place_changed', function () {
        var place = autocomplete.getPlace();
        var jsonData = JSON.stringify(place, null, 2);

        const parsedData = JSON.parse(jsonData);
        const addressComponents = parsedData.address_components;

        // 주소 정보 저장
        selectedAddress = place.formatted_address || "주소 없음";
        selectedZipcode = addressComponents.find(component => component.types.includes("postal_code"))?.short_name || "우편번호 없음";
        selectedAddressDetail = place.name || "";
    });
}

// "주소 가져오기" 버튼 클릭 시 적용
document.getElementById("getAddressBtn").addEventListener("click", function () {
    document.getElementById("addressBox").value = selectedAddress;
    if (selectedAddressDetail) {
        document.getElementById("addressDetailBox").value = selectedAddressDetail;
    }
    document.getElementById("zipcodeBox").value = selectedZipcode;
    
    document.getElementById("zipcodeBox").focus();
    document.getElementById("addressBox").focus();
    document.getElementById("addressDetailBox").focus();
});

document.addEventListener("DOMContentLoaded", function () {
    initAutocomplete();
    vailPassword();
});

// 초기화 함수
function initForm() {
    document.getElementById("username").value = "";
    document.getElementById("usernameBox").value = "";
    document.getElementById("password").value = "";
    document.getElementById("passwordBox").value = "";
    document.getElementById("confirmPasswordBox").value = "";
    document.getElementById("name").value = "";
    document.getElementById("nameBox").value = "";
    document.getElementById("mobile").value = "";
    document.getElementById("mobileBox1").value = "010";
    document.getElementById("mobileBox2").value = "";
    document.getElementById("mobileBox3").value = "";
    document.getElementById("email").value = "";
    document.getElementById("emailBox1").value = "";
    document.getElementById("emailBox2").selectedIndex = 0;
    document.getElementById("zipcode").value = "";
    document.getElementById("zipcodeBox").value = "";
    document.getElementById("address").value = "";
    document.getElementById("addressBox").value = "";
    document.getElementById("addressDetailBox").value = "";
}

</script>
