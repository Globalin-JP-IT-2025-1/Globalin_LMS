<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="member" value="${member}" />


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

<!-- 수정 -->
<!-- @RequestMapping(value = "/{membersId}", method = RequestMethod.PUT) -->
<form action="members/${membersId}" method="post">
	<input type="hidden" name="_method" value="put">
	<input type="submit" value="수정">
</form>

<!-- 삭제  -->
<!-- @RequestMapping(value = "/{membersId}", method = RequestMethod.DELETE) -->
<form action="members/${membersId}" method="post">
	<input type="hidden" name="_method" value="delete"> 
	<input type="submit" value="삭제">
</form>
