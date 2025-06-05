<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="member" value="${member}" />
<%-- <c:set var="emailParts" value="${fn:split(member.email, '@')}" /> --%>
<c:set var="mobileParts" value="${fn:split(member.mobile, '-')}" />

<!-- 회원 정보 수정 폼 -->

<!-- 수정 요청 -->
<!-- @RequestMapping(value = "/{membersId}", method = RequestMethod.PUT) -->
<form action="/members/${membersId}" method="post" onsubmit="return checkBlank(this)">
	<input type="hidden" name="_method" value="put">
	<ul class="editMemberInfoForm">
		<li>members_id(DB) : <input type="hidden" value="${member.membersId}" disabled><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>status(DB) : <input type="hidden" id="status" value="${not empty member.status ? member.status : 0}" readonly><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>status(유저) : <input type="text" value="${member.status eq 0 ? '준회원' : member.status eq 1 ? '정회원' : '대출정지'}" readonly>
		<li>card_num(DB) : <input type="hidden" value="${not empty member.cardNum ? member.cardNum : ''}" readonly><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>card_num(유저) : <input type="text" value="${not empty member.cardNum ? member.cardNum : '도서관 방문 후 도서 이용이 가능합니다.'}" readonly><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>email(DB) : <input type="email" id="email" value="${member.email}" readonly><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>password(DB) : <input type="password" id="password" placeholder="비밀번호 입력" maxlength="20"></li>
		<li>password 확인 : <input type="password" id="confirmPassword" placeholder="비밀번호 입력" maxlength="20"><span id="pwMessage"></span></li>
		<li>name(DB) : <input type="text" value="${member.name}" readonly><span style="color:red; font-weight:bold;">변경 불가</span></li>
		<li>mobile(유저) : 
			<input type="text" id="mobile1" value="${mobileParts[0]}" maxlength="3">-
			<input type="text" id="mobile2" value="${mobileParts[1]}" maxlength="4">-
			<input type="text" id="mobile3" value="${mobileParts[2]}" maxlength="4">
		</li>
		<li>mobile(DB) : <input type="text" id="mobile" value="${member.mobile}"></li> <!-- 테스트 후 hidden으로 변경하기 -->
		<li>zipcode(DB) : <input type="text" id="zipcode" value="${member.zipcode}" maxlength="10"></li>
		<li>address(DB) : <input type="text" id="address" value="${member.address}" maxlength="100"><a href="#">주소찾기</a></li>
		<li>join_date(DB) : <input type="text" id="joinDate" value="${member.joinDate}" readonly></li><!-- 테스트 후 hidden으로 변경 -->
		<li>leave_date(DB) : <input type="text" id="leaveDate" value="${member.leaveDate}" readonly></li><!-- 테스트 후 hidden으로 변경 -->
	</ul>
	<br>
	<button type="button" onclick="cancelEdit()">수정취소</button> 
	<button type="submit">수정</button>
</form>

<script>
// 수정 취소
function cancelEdit() {
	const confirmCancel = confirm("정말 취소하겠습니까?");
	if (confirmCancel) {
		history.back();
	}
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
