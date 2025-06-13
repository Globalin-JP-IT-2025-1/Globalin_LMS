<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="member" value="${member}" />
<c:set var="emailParts" value="${fn:split(member.email, '@')}" />
<c:set var="mobileParts" value="${fn:split(member.mobile, '-')}" />

<!-- Bootstrap CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdCqFS0zt7GHORgwR0lM7muaNSnA0swh4&libraries=places"></script>

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

<!-- 회원 정보 수정 요청 -->
<div class=""> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="vailRequestData()">유효성 검사</button>
	<button onclick="testInsertMember()">회원가입 테스트</button>
</div>

<div class="container d-flex flex-column justify-content-center align-items-center editForm">
	
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">아이디</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="usernameBox" class="form-control bg-secondary-subtle" value="${member.username}" maxlength="20" readonly>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">비밀번호</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="passwordBox" class="form-control" value="" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 password로 변경하기 -->
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">비밀번호 확인</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="confirmPasswordBox" class="form-control" value="" placeholder="비밀번호 입력" maxlength="20"><!-- 테스트 후 password로 변경하기 -->
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
            <input type="text" id="nameBox" class="form-control bg-secondary-subtle" value="${member.name}" maxlength="30" readonly>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">이메일</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="emailBox1" class="form-control" value="${emailParts[0]}" placeholder="이메일 입력" maxlength="30">
            <i class="bi bi-at"></i>
            <select id="emailBox2" class="form-select">
	            <option value="gmail.com" ${emailParts[0] eq 'gmail.com' ? 'selected' : ''}>gmail.com</option>
	            <option value="naver.com" ${emailParts[0] eq 'naver.com' ? 'selected' : ''}>naver.com</option>
	            <option value="test.com" ${emailParts[0] eq 'test.com' ? 'selected' : ''}>test.com</option>
	        </select>
	        <button class="btn btn-primary">중복확인</button>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">전화번호</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="mobileBox1" class="form-control" value="${mobileParts[0]}" maxlength="3">-
			<input type="text" id="mobileBox2" class="form-control" value="${mobileParts[1]}" maxlength="4">-
			<input type="text" id="mobileBox3" class="form-control" value="${mobileParts[2]}" maxlength="4">
        </div>
    </div>

	<!-- 주소 파트 -->
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">주소</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="addressBox" class="form-control" value="${member.address}" placeholder="주소 자동 입력" readonly>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal">주소찾기</button>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">상세 주소</div>
        <div class="input-group d-flex align-items-center">
            <input type="text" id="addressDetailBox" class="form-control" value="${member.addressDetail}" placeholder="상세 주소 입력">
        </div>
    </div>

    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">우편번호</div>
        <div class="input-group d-flex align-items-center">
        	<input type="text" id="zipcodeBox" class="form-control" value="${member.zipcode}" placeholder="우편번호 자동 입력">
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
        <button class="mb-3 btn btn-secondary" onclick="cancelEdit()">수정취소</button>
		<button class="mb-3 btn btn-primary" onclick="updateMemberInfo(${member.membersId})">수정</button>
    </div>
	
</div>


<!-- 서버 통신용 -->
<div class="container d-flex flex-column justify-content-center align-items-center d-none"> <!-- 테스트시: d-none 해제 -->
	<h3>서버 송신용</h3>
	<ol>
		<li>password : <input type="text" id="editForm-password" value="" readonly></li>
		<li>email : <input type="text" id="editForm-email" value="${member.email}" readonly></li>
		<li>mobile : <input type="text" id="editForm-mobile" value="${member.mobile}" readonly></li>
		<li>zipcode : <input type="text" id="editForm-zipcode" value="${member.zipcode}" readonly></li>
		<li>address : <input type="text" id="editForm-address" value="${member.address}" readonly></li>
		<li>addressDetail : <input type="text" id="editForm-address" value="${member.addressDetail}" readonly></li>
	</ol>
	
	<h3>서버 수신용</h3>
	<ul>
		<li>members_id : <input type="text" id="${member.membersId}"></li>
		<!--  <li>status : <input type="text" id="status"></li> -->
		<!-- <li>card_num : <input type="text" id="cardNum"></li> -->
	</ul>
</div>


<!-- Bootstrap 모달창 -->
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

function testUpdateMember() {
	// 빈 값, 비밀번호 일치 여부(pwMatchStatus=0)
	vailFormData();
	// 비밀번호 자릿수 검사(8자 이상)
	vailRequestData();
	
	var password = document.getElementById("editForm-password").value;
	var email = document.getElementById("editForm-email").value;
	var mobile = document.getElementById("editForm-mobile").value;
	var zipcode = document.getElementById("editForm-zipcode").value;
	var address = document.getElementById("editForm-address").value;
	var addressDetail = document.getElementById("regForm-addressDetail").value;
	
	alert(" password: " + password 
			+ " email: " + email + " mobile: " + mobile
			+ " zipcode: " + zipcode + " address: " + address + " addressDetail: " + addressDetail);
	
	alert("회원 정보 수정 요청데이터 테스트 완료");

}

// 수정 취소
function cancelEdit() {
	const confirmCancel = confirm("정말 취소하겠습니까?");
	if (confirmCancel) {
		history.back();
	}
}

// 수정 요청
function updateMemberInfo(membersId) {
	// 빈 값, 비밀번호 일치 여부(pwMatchStatus=0)
	vailFormData();
	// 비밀번호 자릿수 검사(8자 이상)
	vailRequestData();
	
	// 폼 데이터 가져오기
    const member = {
        password: document.getElementById("editForm-password").value,
        email: document.getElementById("editForm-email").value,
        mobile: document.getElementById("editForm-mobile").value,
        zipcode: document.getElementById("editForm-zipcode").value,
        address: document.getElementById("editForm-address").value,
        addressDetail: document.getElementById("regForm-addressDetail").value
    };
	
	Swal.fire({
        title: "회원 정보 수정",
        text: "회원 정보 하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "수정",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/private/members/${membersId}`, { 
            	method: "PUT",
            	headers: { "Content-Type": "application/json" },
                body: JSON.stringify(member) // 객체를 JSON 문자열로 변환
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("수정 완료", "회원 정보가 수정 되었습니다.", "success").then(() => {
                    	location.reload(); // 페이지 새로고침
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

// 폼 빈 칸 검사
function vailFormData() {
	
	/* if (document.getElementById("usernameBox").value.trim() === "") {
	    alert("아이디가 비어있습니다");
	    document.getElementById("usernameBox").focus();
	    return;
	} */
	
	if (document.getElementById("passwordBox").value.trim() === "") {
	    alert("비밀번호가 비어있습니다");
	    document.getElementById("passwordBox").focus();
	    return;
	}
	if (document.getElementById("confirmPasswordBox").value.trim() === "") {
	    alert("비밀번호 확인이 비어있습니다");
	    document.getElementById("confirmPasswordBox").focus();
	    return;
	}
	
	/* if (document.getElementById("nameBox").value.trim() === "") {
	    alert("이름이 비어있습니다");
	    document.getElementById("nameBox").focus();
	    return;
	} */
	
	if (document.getElementById("emailBox1").value.trim() === "") {
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
	
	if (document.getElementById("zipcodeBox").value.trim() === "") {
	    alert("우편번호가 비어있습니다");
	    document.getElementById("zipcodeBox").focus();
	    return;
	}
	
	if (document.getElementById("addressBox").value.trim() === "") {
	    alert("주소가 비어있습니다");
	    document.getElementById("addressBox").focus();
	    return;
	}

	if (document.getElementById("addressDetailBox").value.trim() === "") {
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
	if (!/.{8,}/.test(document.getElementById("editForm-password").value)) {
	    alert("비밀번호는 8자 이상이어야 합니다.");
	    document.getElementById("passwordBox").focus();
	    return;
	}

}

// 서버 송신용 input 채우기
document.getElementById("usernameBox").addEventListener("blur", function () {
	document.getElementById("editForm-username").value = this.value;
});

document.getElementById("passwordBox").addEventListener("blur", function () {
	document.getElementById("editForm-password").value = this.value;
});

document.getElementById("nameBox").addEventListener("blur", function () {
    document.getElementById("editForm-name").value = this.value;
});

document.getElementById("zipcodeBox").addEventListener("blur", function () {
    document.getElementById("editForm-zipcode").value = this.value;
});

document.getElementById("addressBox").addEventListener("blur", function () {
    document.getElementById("regForm-address").value = this.value;
});

document.getElementById("addressDetailBox").addEventListener("blur", function () {
    document.getElementById("regForm-address").value = this.value;
});


// 이메일 합치기 + 값 검사
document.getElementById("emailBox1").addEventListener("input", function() {
	let value1 = this.value;

    // 특수문자 포함 여부 확인 (영문, 숫자만 허용)
    if (/[^a-zA-Z0-9]/.test(value1)) {
        alert("이메일은 영문과 숫자만 사용할 수 있습니다");
        document.getElementById("emailBox1").value = "";
    }
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

    document.getElementById("editForm-mobile").value = originalValue1 + "-" + originalValue2 + "-" + originalValue3;
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
    
    document.getElementById("addressDetailBox").focus();
    document.getElementById("zipcodeBox").focus();
});

document.addEventListener("DOMContentLoaded", function () {
    initAutocomplete();
    vailPassword();
});

</script>
