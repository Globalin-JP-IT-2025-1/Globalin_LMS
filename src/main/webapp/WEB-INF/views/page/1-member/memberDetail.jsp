<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="member" value="${member}" />
<%-- <c:set var="bookOverdueInfo" value="${bookOverdueInfo}" /> --%>
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
              		<p class="badge text-bg-light">준회원</p>
              	</c:when>
              	<c:when test="${member.status eq 1}">
              		<p class="badge text-bg-success">정회원</p>
              	</c:when>
              	<c:when test="${member.status eq 2}">
              		<p class="badge text-bg-danger">대출정지</p>
              	</c:when>
              	<c:when test="${member.status eq 3}">
              		<p class="badge text-bg-secondary">탈퇴회원</p>
              	</c:when>
              	<c:when test="${member.status eq 9}">
              		<p class="badge text-bg-primary">관리자</p>
              	</c:when>
              	<c:otherwise>
              		null
              	</c:otherwise>
        	</c:choose>
        </div>
    </div>
    
    <div class="mb-3 col-6 d-flex gap-2">
    	<div class="col-3 d-flex align-items-center">회원카드 번호</div>
        <div class="input-group d-flex align-items-center">
        	<c:choose>
        		<c:when test="${not empty member.cardNum}">
        			${member.cardNum}
        		</c:when>
        		<c:otherwise>
        			<p class="text-success">도서관에 방문하여 대출증을 만들면, 정회원으로 전환하실 수 있습니다.</p>
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
    
    <c:if test="${member.status eq 3}">
	    <div class="mb-3 col-6 d-flex align-items-center gap-2 bg-warning-subtle">
	        <p class="text-danger"><i class="bi bi-exclamation-triangle"></i> 연체된 도서 총 ${bookOverdueInfo.conut} 권 있습니다</p>
	    </div>
    </c:if>
    
    <div class="mb-3 col-6 d-flex justify-content-center align-items-center gap-2">
    	<form action="/private/members/${member.membersId}" method="post">
    		<input type="hidden" name="_method" value="PUT">
        	<input class="d-none" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        	<input class="d-none" type="text"name="membersId" id="membersId" value="${member.membersId}" readonly>
        	<input class="mb-3 btn btn-secondary" type="submit" value="탈퇴">
        </form>
		<button class="mb-3 btn btn-primary" onclick="window.load.href='/private/members/${member.membersId}/edit'">수정</button>
    </div>
</div>


