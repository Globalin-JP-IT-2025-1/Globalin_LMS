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
	<li>status : ${member.status}</li>
	<li>card_num : ${member.cardNum}</li>
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
<a href="/members/${membersId}/edit">수정</a>

<!-- 탈퇴 요청 (수정 요청)  -->
<!-- @RequestMapping(value = "/{membersId}", method = RequestMethod.PUT) -->
<form action="/members/${membersId}" method="post">
	<input type="hidden" name="_method" value="delete"> 
	<input type="submit" value="탈퇴">
</form>

