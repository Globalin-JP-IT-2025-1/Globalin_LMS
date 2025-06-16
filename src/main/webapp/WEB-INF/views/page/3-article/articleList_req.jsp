<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- 게시글 목록 조회 - 희망도서 신청 -->


<h2>[희망 도서 신청] 목록 조회</h2>






<!-- 시큐리티 taglib 예시 -->
<%-- <sec:authorize access="hasRole('USER')">
    <sec:authentication property="principal" var="principal" />
    <P>${principal}</P>
    <h2>${principal.username} 회원님 환영합니다!!!</h2>
    <form action="/private/auth/logout/2" method="post">
        <sec:csrfInput/>
        <button type="submit">로그아웃</button>
    </form>
</sec:authorize> --%>