<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h1>${message}</h1>
<br>
<h2>~~ DB 연결 테스트 ~~</h2><br>
<h3>관리자 전용 페이지</h3><br>
<a href="/user/list" id="userList">회원 목록</a><br>
<br>
<h3>공통 페이지</h3>
<a href="/user/loginForm/0" id="loginForm">로그인</a>
<a href="/user/regForm" id="regForm">회원가입</a>
<br>

<c:if test="${not empty userid}">
	<p>(로그인 성공!)</p>
	<a href="/user/mypage/${userid}" id="mypage">마이페이지</a><br>
</c:if>

현재 사용자: <c:out value="${empty userid ? '게스트' : userid}" />
