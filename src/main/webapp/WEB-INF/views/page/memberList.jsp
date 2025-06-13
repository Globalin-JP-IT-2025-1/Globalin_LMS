<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="memberList" value="${memberList}" />
<fmt:formatDate value="${joinDate.time}" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${leaveDate.time}" pattern="yyyy-MM-dd" />

<style>
#memberList, #memberList > tr, th, td {
	border: 1px solid var(--main-color);
	border-collapse: collapse;
	border-spacing: 0;
}

#memberList th {
	background-color: var(--gray-color);
}

.memberList_summary,
.memberList_content {
	width: 100%;
}

.memberList_content button {
	width: 100px;
}

</style>

<!-- 조회 -->
<!-- @GetMapping("/admin/members") -->
<div class="memberList_summary">
	전체 ${fn:length(memberList)} 건
	<select id="searchType">
		<option id="st_cardnum">카드번호</option>
		<option id="st_username">아이디</option>
		<option id="st_name">성함</option>
		<option id="st_mobile">핸드폰번호</option>
	</select>
	<input type="text" id="searchKeyword"><button id="search">검색</button>
</div>
<br>
<div class="memberList_content">
	<table id="memberList">
		<tr>
			<th>NO</th>
			<th>MEMBERS_ID</th>
			<th>회원 상태</th>
			<th>회원 카드 번호</th>
			<th>회원 카드 번호</th>
			<th>이메일</th>
			<th>비밀번호</th> <!-- 테스트 후 삭제 -->
			<th>이름</th>
			<th>연락처</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>상세 주소</th>
			<th>가입날짜</th>
			<th>탈퇴날짜</th>
			<th>삭제</th>
			<th>등급 변경</th>
			<th>수정 폼</th> <!-- 테스트 후 삭제 -->
		</tr>
	
		<c:forEach var="member" items="${memberList}">
			<c:set var="cnt" value="${cnt + 1}" />
			<tr>
				<td>${cnt}</td>
				<td>${member.membersId}</td>
				<td>${member.status}</td>
				<td>${member.cardNum}</td>
				<td>${member.overdue}</td>
				<td>${member.email}</td>
				<td>${member.password}</td>
				<td>${member.mobile}</td>
				<td>${member.name}</td>
				<td>${member.zipcode}</td>
				<td>${member.address}</td>
				<td>${member.addressDetail}</td>
				<td>${member.joinDate}</td>
				<td>${member.leaveDate}</td>
		        <td><button onclick="deleteMember(${member.membersId})">삭제</button></td>
		        <td><button onclick="upgradeMember(${member.membersId})" id="data-swal-toast-template">정회원으로 변경</button></td>
		        <td><button onclick="window.location.href='/private/members/${member.membersId}'">정보 수정</button></td>
			</tr>
		</c:forEach>
	
	</table>
</div>

<script type="text/javascript">
function deleteMember(membersId) {
	Swal.fire({
        title: "회원 삭제",
        text: "정말로 회원을 삭제하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "삭제",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/private/members/${membersId}`, { 
            	method: "DELETE"
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("삭제 완료", "회원이 삭제되었습니다.", "success").then(() => {
                        location.reload(); // 페이지 새로고침
                    });
                } else {
                    Swal.fire("오류 발생", "회원 삭제에 실패했습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
                console.error("Error:", error);
            });
        }
    });
}

function upgradeMember(membersId) {
    Swal.fire({
        title: "회원 등급 수정",
        text: "해당 회원을 정회원으로 변경하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "변경",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            generateCardNumber(membersId); // 카드번호 생성 함수 호출
        }
    });
}

function generateCardNumber(membersId) {
    Swal.fire({
        title: "회원카드 번호 입력",
        input: "text",
        inputPlaceholder: "카드번호를 입력하거나 생성하세요",
        showCancelButton: true,
        confirmButtonText: "카드번호 생성",
        cancelButtonText: "취소",
        preConfirm: () => {
            return fetch(`/admin/members/cardnumber`)
                .then(response => response.json())
                .then(data => {
                    if (!data.cardNumber) {
                        throw new Error("카드번호 생성 실패");
                    }
                    return data.cardNumber; // 입력창에 자동 반영
                })
                .catch(error => {
                    Swal.showValidationMessage(`에러 발생: ${error}`);
                });
        }
    }).then((cardResult) => {
        if (cardResult.isDismissed) {
            Swal.fire("취소됨", "회원 등급 변경이 취소되었습니다.", "info");
            return;
        }
        
        // 회원 정보 수정 버튼 추가
        Swal.fire({
            title: "회원정보 수정하기",
            text: "회원정보를 수정하시겠습니까?",
            icon: "info",
            showCancelButton: true,
            confirmButtonText: "수정하기",
            cancelButtonText: "취소"
        }).then((editResult) => {
            if (editResult.isConfirmed) {
                fetch(`/admin/members/${membersId}/upgrade`, { 
                    method: "PUT",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ cardNumber: cardResult.value }) 
                })
                .then(response => {
                    if (response.ok) {
                        Swal.fire("변경 완료", "회원 등급이 정회원으로 변경되었습니다.", "success");
                    } else {
                        Swal.fire("오류 발생", "회원 정보 수정에 실패했습니다.", "error");
                    }
                })
                .catch(error => {
                    Swal.fire("서버 오류", "회원 정보 수정 중 문제가 발생했습니다.", "error");
                    console.error("Error:", error);
                });
            }
        });
    });
}

</script>
