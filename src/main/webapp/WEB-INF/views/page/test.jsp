<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="member" value="${member}" />

<!-- 삭제  -->
<!-- @RequestMapping(value = "/test/{id}", method = RequestMethod.DELETE) -->
<form action="/test/${id}" method="post">
	<input type="hidden" name="_method" value="delete"> 
	<input type="submit" value="삭제">
</form>

<!-- 수정 -->
<!-- @RequestMapping(value = "/test/{id}", method = RequestMethod.PUT) -->
<form action="/test/${id}" method="post">
	<input type="hidden" name="_method" value="put">
	<input type="submit" value="수정">
</form>

<!-- 조회 -->
<!-- @GetMapping("/test/{id}") -->
<!-- @GetMapping("/test") -->
<form action="/test" method="post">
이메일 : <input type="email" name="email" />
이름 : <input type="text" name="name" />
<input type="email" name="email" />
</form>



