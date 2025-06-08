<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="member" value="${member}" />
<fmt:formatDate value="${joinDate}" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${leaveDate}" pattern="yyyy-MM-dd" />

<!-- 회원 상세 조회 -->
<!-- @GetMapping("/members/{membersId}") -->
<ul class="memberDetailForm">
	<li>members_id : ${member.membersId}</li>
	<li>status : ${member.status eq 0 ? '준회원' : member.status eq 1 ? '정회원' : '대출정지'}</li>
	<li>card_num : ${not empty member.cardNum ? member.cardNum : '도서관 방문 후 도서 이용이 가능합니다.'}</li>
	<li>email : ${member.email}</li>
	<li>password : ${member.password}</li>
	<li>name : ${member.name}</li>
	<li>mobile : ${member.mobile}</li>
	<li>zipcode : ${member.zipcode}</li>
	<li>address : ${member.address}</li>
	<li>join_date : ${member.joinDate}</li>
	<li>leave_date : ${member.leaveDate}</li>
</ul>
<br>

<!-- 수정 폼으로 이동 -->
<a href="/private/members/${member.membersId}/edit">수정</a> <!-- GET private/members/${membersId}/edit -->

<!-- 탈퇴 요청 -->
<button onclick="leaveMember(${member.membersId})">탈퇴</button>

<script>
// 탈퇴 요청
function leaveMember(memberId) {
	Swal.fire({
        title: "회원 탈퇴",
        text: "정말로 탈퇴 하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "탈퇴",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/private/members/${membersId}/leave`, { 
            	method: "PATCH"
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("탈퇴 완료", "탈퇴가 완료 되었습니다.", "success").then(() => {
                    	location.href = "/"; // 홈으로 이동
                    });
                } else {
                    Swal.fire("오류 발생", "탈퇴를 실패했습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
                console.error("Error:", error);
            });
        }
    });
}

</script>

