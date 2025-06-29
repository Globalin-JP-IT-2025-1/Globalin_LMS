<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="bookList" value="${bookList}" />

<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<style>
.bookList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.bookList td, .bookList th {
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
}

/* 각 열 너비 */
.bookList td:nth-child(1), .bookList th:nth-child(1) { width: 5% !important; }
.bookList td:nth-child(2), .bookList th:nth-child(2) { width: 10% !important; }
.bookList td:nth-child(3), .bookList th:nth-child(3) { width: 65% !important; }
.bookList td:nth-child(4), .bookList th:nth-child(4) { width: 10% !important; }
.bookList td:nth-child(5), .bookList th:nth-child(5) { width: 5% !important; }
.bookList td:nth-child(6), .bookList th:nth-child(6) { width: 5% !important; }

</style>

<!-- 도서 인기도서 목록 조회 -->
<div class="container mt-4">
	<!-- 요약 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
    </div>
    
    <!-- 도서 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover bookList">
	    	<thead>
	        	<tr>
	        		<th>NO</th>
	        		<th>도서 표지</th>
	        		<th>도서 정보</th>
	        		<th>도서 상태</th>
	        		<th>조회수</th>
	        		<th>리뷰수</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
	        		<c:when test="${empty bookList}">
	        			<td colspan="6" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty bookList}">
			            <c:forEach var="i" begin="0" end="${fn:length(bookList) - 1}" step="1">
			                <tr onclick="location.href='/public/articles/not/${bookList[i].booksId}'">
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>
				                    <img src="${bookList[i].imageLink}"
				                        alt="${bookList[i].title} 책 표지" width="50">
				                </td>
				                <td>
				                    <div class="text-secondary mb-1">
				                    	총류 > 총류
				                    </div>
				                    <div class="fw-bold fs-4 mb-2">${bookList[i].title}</div>
				                    <div class="d-flex flex-wrap mb-2 gap-3">
				                        <div><span class="fw-semibold">저자:</span> ${bookList[i].author}</div>
				                        <div><span class="fw-semibold">출판사:</span> ${bookList[i].publisher}</div>
				                        <div><span class="fw-semibold">출판연도:</span> <fmt:formatDate value="${bookList[i].publishDate}" pattern="yyyy" /></div>
				                    </div>
				                    <div class="d-flex flex-wrap mb-2 gap-3">
				                        <div><span class="fw-semibold">ISBN:</span> ${bookList[i].isbn}</div>
				                        <div><span class="fw-semibold">분류기호:</span> ${bookList[i].category}</div>
				                        <div><span class="fw-semibold">도서관:</span> 글로벌인 도서관</div>
				                        <div><span class="fw-semibold">자료실:</span> 일반자료실</div>
				                    </div>
				                </td>
				                <td>
				                    <div class="d-flex flex-column gap-2">
				                        <div class="mb-2 text-danger fw-semibold">
				                        	${bookList[i].status}
				                        </div>
				                        <button class="btn btn-secondary btn-sm" disabled>도서예약불가</button>
				                        <button class="btn btn-outline-success btn-sm">관심도서담기</button>
				                    </div>
				                </td>
			                    <td>${bookList[i].viewCount}</td>
			                    <td>${bookList[i].reviewCount}</td>
			                </tr>
			            </c:forEach>
			        </c:when>
		        </c:choose>
	        </tbody>
	    </table>
	    
	    <!-- 도서 추가하기 버튼 : 관리자만 보이기 -->
	    <div class="d-flex justify-content-end">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
	   			<button class="btn btn-primary mb-6" onclick="location.href='/admin/books/add'">작성하기</button>
		  	</sec:authorize>
	  	</div>
	  	
	  	<c:choose>
        	<c:when test="${not empty bookList}">
			    <!-- 페이징 -->
			    <div class="d-flex justify-content-center mt-4">
				    <nav aria-label="Page navigation">
				        <ul class="pagination">
				
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage - 1}">이전</a>
				                </li>
				            </c:if>
				
				            <c:forEach var="i" begin="${startPage}" end="${endPage}">
							    <li class="page-item ${i == currentPage ? 'active' : ''}">
							        <a class="page-link" href="?page=${i}">${i}</a>
							    </li>
							</c:forEach>
				
				            <c:if test="${currentPage < totalPages}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage + 1}">다음</a>
				                </li>
				            </c:if>
				        </ul>
				    </nav>
				</div>
			</c:when>
		</c:choose>
    </div>
</div>