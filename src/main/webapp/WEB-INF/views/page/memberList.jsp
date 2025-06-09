<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="memberList" value="${memberList}" />
<fmt:formatDate value="${joinDate}" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${leaveDate}" pattern="yyyy-MM-dd" />

<style>
#memberList, #memberList tr, th, td {
border: 1px solid var(--main-color);
border-collapse: collapse;
}

#memberList th {
background-color: var(--gray-color);
}

</style>

<!-- 조회 -->
<!-- @GetMapping("/members") -->
<div>
	전체 ${fn:length(memberList)} 건
	<select id="searchType">
		<option id="cardnum">카드번호</option>
	</select>
	<input type="text" id="searchKeyword"><button id="search">검색</button>
</div>

<div>

	<table id="memberList">
		<tr>
			<th>NO</th>
			<th>MEMBERS_ID</th>
			<th>회원 상태<br>STATUS</th>
			<th>회원 카드 번호<br>CARD_NUM</th>
			<th>이메일<br>EMAIL</th>
			<th>비밀번호<br>PASSWORD</th> <!-- 테스트 후 삭제 -->
			<th>성함<br>NAME</th>
			<th>연락처<br>MOBILE</th>
			<th>우편번호<br>ZIPCODE</th>
			<th>주소<br>ADDRESS</th>
			<th>가입날짜<br>JOIN_DATE</th>
			<th>탈퇴날짜<br>LEAVE_DATE</th>
			<!-- <th>회원 정보 삭제</th> -->
			<th>회원 등급 변경</th>
		</tr>
	
		<c:forEach var="member" items="${memberList}">
		<c:set var="cnt" value="${cnt + 1}" />
			<tr>
				<td>${cnt}</td>
				<td>${member.membersId}</td>
				<td>${member.status}</td>
				<td>${member.cardNum}</td>
				<td>${member.email}</td>
				<td>${member.password}</td>
				<td>${member.mobile}</td>
				<td>${member.name}</td>
				<td>${member.zipcode}</td>
				<td>${member.address}</td>
				<td>${member.joinDate}</td>
				<td>${member.leaveDate}</td>
		        <%-- <td><button onclick="deleteMember(${member.membersId})">삭제</button></td> --%>
		        <td><button onclick="upgradeMember(${member.membersId})">정회원으로 변경</button></td>
			</tr>
		</c:forEach>
	
	</table>
</div>

<td><button onclick="deleteMember(${member.membersId})">삭제</button></td>

<script>
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

function upgradeMember(memberId) {
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
            fetch(`/private/members/${membersId}/grade`, { 
            	method: "PATCH"
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("변경 완료", "회원 등급이 정회원으로 변경되었습니다.", "success").then(() => {
                        location.reload(); // 페이지 새로고침
                    });
                } else {
                    Swal.fire("오류 발생", "회원 등급 변경에 실패했습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("서버 오류", "네트워크 문제 또는 서버 오류가 발생했습니다.", "error");
                console.error("Error:", error);
            });
        }
    });
}

</script>
