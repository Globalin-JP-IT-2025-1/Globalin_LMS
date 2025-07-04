<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="book" value="${book}" />

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/articleDetail.css">

<div class="container-fluid py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="row g-0 align-items-center">
                    <div class="col-md-4 text-center">
                        <img src="${book.imageLink}" alt="${book.title} 책 표지" width="200">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <div class="text-secondary mb-1">
                            	<c:choose>
									<c:when test="${book.category eq '000'}">총류</c:when>
									<c:when test="${book.category eq '100'}">철학</c:when>
									<c:when test="${book.category eq '200'}">종교</c:when>
									<c:when test="${book.category eq '300'}">사회과학</c:when>
									<c:when test="${book.category eq '400'}">자연과학</c:when>
									<c:when test="${book.category eq '500'}">기술과학</c:when>
									<c:when test="${book.category eq '600'}">예술</c:when>
									<c:when test="${book.category eq '700'}">언어</c:when>
									<c:when test="${book.category eq '800'}">문학</c:when>
									<c:when test="${book.category eq '900'}">역사</c:when>
									<c:otherwise>기타</c:otherwise>
		                    	</c:choose>
                            </div>
                            <div class="fw-bold fs-4 mb-2">${book.title}</div>
                            <div class="mb-2">
                                <div>저자: ${book.author}</div>
                                <div>출판사: ${book.publisher}</div>
                                <div>출판연도: <fmt:formatDate value="${book.publishDate}" pattern="yyyy" /></div>
                                <div>ISBN: ${book.isbn}</div>
                                <div>분류기호: ${book.category}</div>
                                <div>도서관: 글로벌인 도서관</div>
                                <div>자료실: 일반자료실</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3 mb-4">
                <div class="d-flex flex-column justify-center">
                   	<c:set var="status">${book.status}</c:set>
                	<c:choose>
                   		<c:when test="${status eq 0}">
                   			<div class="badge text-bg-success">대출가능</div>
                   		</c:when>
                   		<c:when test="${status eq 1}">
                   			<div class="badge text-bg-secondary">비공개</div>
                   		</c:when>
                   		<c:when test="${status eq 2}">
                   			<div class="badge text-bg-info">대출 중</div>
                   		</c:when>
                   		<%-- <c:when test="${status eq 3}">
                   			<div class="badge text-bg-danger">대출 예약 중</div>
                   		</c:when> --%>
                   		<c:otherwise>
                   			알 수 없음
                   		</c:otherwise>
                   	</c:choose>
	                <button class="btn btn-outline-success btn-sm">관심도서담기</button>
                </div>
            </div>
            <div>
                <div class="text-secondary">도서상세정보 보기</div>
            </div>
        </div>
    </div>
</div>