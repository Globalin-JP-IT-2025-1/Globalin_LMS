<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="member" value="${member}" />
<c:set var="memberDetail" value="${memberDetail}" />
<fmt:formatDate value="${joinDate}" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${leaveDate}" pattern="yyyy-MM-dd" />

<!-- 회원 상세 조회 -->
<!-- @GetMapping("/members/{membersId}") -->

<div class="container d-flex flex-column justify-content-center align-items-center memberDetailForm">
	
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">아이디</div>
        <div class="input-group d-flex align-items-center">
        	${member.name} (${member.username})
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">상태</div>
        <div class="input-group d-flex align-items-center">
        	<c:choose>
        		<c:when test="${member.status eq 0}">
        			준회원
        		</c:when>
        		<c:when test="${member.status eq 1}">
        			정회원
        		</c:when>
        		<c:otherwise>
        			<p class="text-danger">대출정지(${member.overdue} 일)</p>
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">회원카드 번호</div>
        <div class="input-group d-flex align-items-center">
        	<c:choose>
        		<c:when test="${member.status eq 2}">
        			${member.cardNum}
        		</c:when>
        		<c:otherwise>
        			<p class="text-success">도서관 방문 후 도서 이용이 가능합니다</p>
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">이메일</div>
        <div class="input-group d-flex align-items-center">
            ${member.email}
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">전화번호</div>
        <div class="input-group d-flex align-items-center">
            ${member.mobile}
        </div>
    </div>

	<!-- 주소 파트 -->
	<div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">주소</div>
        <div class="input-group d-flex align-items-center">
            ${member.address}
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">상세 주소</div>
        <div class="input-group d-flex align-items-center">
            ${member.addressDetail}
        </div>
    </div>

    <div class="mb-3 col-6 d-flex gap-2">
        <div class="col-3 d-flex align-items-center">우편번호</div>
        <div class="input-group d-flex align-items-center">
        	${member.zipcode}
        </div>
    </div>
    
    <c:if test="${member.overdue ne 0}">
	    <div class="mb-3 col-6 d-flex align-items-center gap-2 bg-warning-subtle">
	        <p class="text-danger"><i class="bi bi-exclamation-triangle"></i> 연체된 도서가 있습니다</p>
	    </div>
    </c:if>
    
    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
        <button class="mb-3 btn btn-secondary" onclick="leaveMember()">탈퇴</button>
		<button class="mb-3 btn btn-primary" onclick="editFormMember()">수정</button>
    </div>
</div>

<!-- 서버 통신용 -->
<div class="container d-flex flex-column justify-content-center align-items-center d-none"> <!-- 테스트시: d-none 해제 -->
	<h3>서버 수신용</h3>
	<ul>
		<li>members_id : <input type="text" id="membersIdBox" value="${member.membersId}"></li>
		<!--  <li>status : <input type="text" id="status"></li> -->
		<!-- <li>card_num : <input type="text" id="cardNum"></li> -->
	</ul>
</div>


<script type="text/javascript">
var membersId = document.getElementById("membersIdBox").value;

// 수정 폼으로 이동
function editFormMember() {
    location.href = `/private/members/${membersId}/edit`;
}

// 탈퇴 요청
function leaveMember() {
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

