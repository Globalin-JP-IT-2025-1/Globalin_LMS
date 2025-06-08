<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="member" value="${member}" />
<%-- <c:set var="emailParts" value="${fn:split(member.email, '@')}" /> --%>
<c:set var="mobileParts" value="${fn:split(member.mobile, '-')}" />
<c:out value="${member.email}" /> <!-- 디버깅용 -->

<!-- 회원 정보 수정 폼 -->
<ul class="editMemberInfoForm">
	<li>members_id(DB) : 
		<input type="text" id="membersId" value="${member.membersId}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>status(DB) : 
		<input type="text" value="${member.status}" readonly>
	status(유저) : 
		<input type="text" value="${member.status eq 0 ? '준회원' : member.status eq 1 ? '정회원' : '대출정지'}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>card_num(DB) : 
		<input type="hidden" value="${not empty member.cardNum ? member.cardNum : ''}" readonly>
	card_num(유저) : 
		<input type="text" value="${not empty member.cardNum ? member.cardNum : '도서관 방문 후 도서 이용이 가능합니다.'}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>id(DB겸유저) : 
		<input type="text" value="${member.username}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>password(DB) : <input type="password" id="password" placeholder="비밀번호 입력" maxlength="20"></li>
	<li>password 확인 : 
		<input type="password" id="confirmPassword" placeholder="비밀번호 입력" maxlength="20">
		<span id="pwMessage"></span>
	</li>
	<li>name(DB) : 
		<input type="text" value="${member.name}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>email(DB) : 
		<input type="email" value="${member.email}" readonly>
		<span style="color:red; font-weight:bold;">변경 불가</span>
	</li>
	<li>mobile(유저) : 
		<input type="text" id="mobile1" value="${mobileParts[0]}" maxlength="3">-
		<input type="text" id="mobile2" value="${mobileParts[1]}" maxlength="4">-
		<input type="text" id="mobile3" value="${mobileParts[2]}" maxlength="4">
	mobile(DB) : 
		<input type="text" id="mobile" value="${member.mobile}">
	</li> <!-- 테스트 후 hidden으로 변경하기 -->
	<li>zipcode(DB겸유저) : <input type="text" id="zipcode" value="${member.zipcode}" maxlength="10"></li>
	<li>address(DB겸유저) : <input type="text" id="address" value="${member.address}" maxlength="100"><a href="#">주소찾기</a></li>
	<li>join_date(DB) : <input type="text" value="${member.joinDate}" readonly></li><!-- 테스트 후 hidden으로 변경 -->
	<li>leave_date(DB) : <input type="text" value="${member.leaveDate}" readonly></li><!-- 테스트 후 hidden으로 변경 -->
</ul>
<br>
<button onclick="cancelEdit()">수정취소</button> 
<button onclick="updateMemberInfo(${member.membersId})">수정</button>

<script src="${pageContext.request.contextPath}/resources/static/js/form.js"></script>


<script>
// 수정 취소
function cancelEdit() {
	const confirmCancel = confirm("정말 취소하겠습니까?");
	if (confirmCancel) {
		history.back();
	}
}

// 수정 요청
function updateMemberInfo(membersId) {

	// 폼 데이터 가져오기
    const member = {
        password: document.getElementById("password").value,
        mobile: document.getElementById("mobile").value,
        zipcode: document.getElementById("zipcode").value,
        address: document.getElementById("address").value
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

// 연락처 합치기
function combineMobile() {
    let value1 = document.getElementById("mobile1").value;
    let value2 = document.getElementById("mobile2").value;
    let value3 = document.getElementById("mobile3").value;
    
    document.getElementById("mobile").value = value1 + "-" + value2 + "-" + value3;
}

// 입력값 변경 시 자동 업데이트
document.getElementById("mobile1").addEventListener("input", combineMobile);
document.getElementById("mobile2").addEventListener("input", combineMobile);
document.getElementById("mobile3").addEventListener("input", combineMobile);

// 비밀번호 일치하는지 확인하기
document.getElementById("confirmPassword").addEventListener("input", function () {
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
