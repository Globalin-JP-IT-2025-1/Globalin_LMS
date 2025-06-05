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
}

#memberList th {
background-color: var(--gray-color);
}

</style>

<!-- 조회 -->
<!-- @GetMapping("/members") -->
전체 ${fn:length(memberList)} 건<br>
<br>
<table id="memberList">
	<tr>
		<th>선택</th>
		<th>NO</th>
		<th>MEMBERS_ID</th>
		<th>STATUS</th>
		<th>CARD_NUM</th>
		<th>EMAIL</th>
		<th>PASSWORD</th>
		<th>NAME</th>
		<th>MOBILE</th>
		<th>ZIPCODE</th>
		<th>ADDRESS</th>
		<th>JOIN_DATE</th>
		<th>LEAVE_DATE</th>
	</tr>

	<c:forEach var="member" items="${memberList}">
	<c:set var="cnt" value="${cnt + 1}" />
		<tr>
			<td>
	            <input type="checkbox" class="checkbox" name="members" value="${member.membersId}" 
	                ${member.leaveDate == null ? "disabled" : ""}>
	        </td>
			<td>${cnt}</td>
			<td>${member.membersId}</td>
			<td>${member.status}</td>
			<td>${member.cardNum}</td>
			<td>${member.email}</td>
			<td>${member.password}</td>
			<td>${member.mobile}</td>
			<td>${member.zipcode}</td>
			<td>${member.address}</td>
			<td>${member.joinDate}</td>
			<td>${member.leaveDate}</td>
		</tr>
	</c:forEach>

</table>

<button id="selectAll">전체 선택</button>
<button id="deselectAll">전체 해제</button>
<br>
<!-- 삭제 요청  -->
<!-- @RequestMapping(value = "/{membersId}", method = RequestMethod.DELETE) -->
<form action="/members/${membersId}" method="post">
	<input type="hidden" name="_method" value="delete"> 
	<input type="submit" value="삭제">
</form>

<script>
    document.getElementById("selectAll").addEventListener("click", function() {
        document.querySelectorAll(".checkbox").forEach(cb => cb.checked = true);
    });

    document.getElementById("deselectAll").addEventListener("click", function() {
        document.querySelectorAll(".checkbox").forEach(cb => cb.checked = false);
    });
</script>
