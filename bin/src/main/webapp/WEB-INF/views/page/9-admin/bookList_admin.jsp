<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:formatDate value="${createDate.time}" pattern="yyyy-MM-dd" />

<style>
#bookList, #bookList > tr, th, td {
	border: 1px solid var(--main-color);
	border-collapse: collapse;
	border-spacing: 0;
}

#bookList th {
	background-color: var(--gray-color);
}

.bookList_summary,
.bookList_content {
	width: 100%;
}

.bookList_content button {
	width: 100px;
}

</style>

<!-- 조회 -->
<!-- @GetMapping("/admin/books") -->
<div class="bookList_summary">
	<%-- 전체 ${fn:length(bookList)} 건 --%>
	<select id="searchType">
		<option id="st_bookname">도서명</option>
		<option id="st_author">저자</option>
		<option id="st_publisher">출판사</option>
	</select>
	<input type="text" id="searchKeyword"><button id="search">검색</button>
</div>
<br>
<button onclick="">도서 등록 폼</button>
<div class="bookList_content">
	<table id="bookList">
		<tr>
			<th>NO</th>
			<th>Books id (DB)</th>
			<th>상태 (DB)</th> <!-- 0: 대출 가능, 1: 대출중, 9: 숨기기  -->
			<th>네이버 도서 code (DB)</th>
			<th>도서 이미지 (API)</th>
			<th>도서명 (API)</th>
			<th>저자 (API)</th>
			<th>출판사 (API)</th>
			<th>출판일 (API)</th>
			<th>구분 (API)</th> <!-- 총류, 철학 등 -->
			<th>등록날짜 (DB)</th>
			<th>보이기/숨기기</th> <!-- 보이기 상태(status=1,2): 숨기기 버튼, 숨기기 상태(status=9): 보이기 버튼-->
			<th>수정 폼</th>
			<th>삭제</th>
		</tr>
	
		<%-- <c:forEach var="book" items="${bookList}">
			<c:set var="cnt" value="${cnt + 1}" />
			<tr>
				<td>${cnt}</td>
				<td>${book.membersId}</td>
				<td>${book.status}</td>
				<td>${book.cardNum}</td>
				<td>${member.email}</td>
				<td>${member.password}</td>
				<td>${member.mobile}</td>
				<td>${member.name}</td>
				<td>${member.zipcode}</td>
				<td>${member.address}</td>
				<td>${member.joinDate}</td>
				<td>${member.leaveDate}</td>
		        <td><button onclick="deleteMember(${member.membersId})">삭제</button></td>
		        <td><button onclick="upgradeMember(${member.membersId})" id="data-swal-toast-template">정회원으로 변경</button></td>
		        <td><button onclick="window.location.href='/private/members/${member.membersId}'">정보 수정</button></td>
			</tr>
		</c:forEach> --%>
	
	</table>
</div>

<script type="text/javascript">

</script>
