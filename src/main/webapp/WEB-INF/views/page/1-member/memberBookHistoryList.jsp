<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="bookHistoryList" value="${bookHistoryList}" />

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
.bookHistoryList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.bookHistoryList td, .bookHistoryList th {
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
}

/* 각 열 너비 */
.bookHistoryList td:nth-child(1), .bookHistoryList th:nth-child(1) { width: 5% !important; }
.bookHistoryList td:nth-child(2), .bookHistoryList th:nth-child(2) { width: 10% !important; }
.bookHistoryList td:nth-child(3), .bookHistoryList th:nth-child(3) { width: 65% !important; }
.bookHistoryList td:nth-child(4), .bookHistoryList th:nth-child(4) { width: 10% !important; }
.bookHistoryList td:nth-child(5), .bookHistoryList th:nth-child(5) { width: 5% !important; }
.bookHistoryList td:nth-child(6), .bookHistoryList th:nth-child(6) { width: 5% !important; }

</style>

<!-- 도서 통합검색 목록 조회 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
        	<form action="/public/books/total" method="get" class="d-flex align-items-center gap-2">
				<select class="form-select form-select-sm w-auto" name="searchType">
				    <option value="title">책제목</option>
				    <option value="author">저자</option>
				    <option value="publisher">출판사</option>
				    <option value="isbn">ISBN</option>
			  	</select>
				<input type="text" class="form-control form-control-sm w-auto" name="searchKeyword" placeholder="검색어 입력">
				<button type="submit" class="btn btn-primary btn-sm">검색</button>
			</form>
	    </div>
    </div>
    
    <!-- 도서 이용 정보 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover bookHistoryList">
	    	<thead>
	        	<tr>
	        		<th>NO</th>
	        		<th>도서 표지</th>
	        		<th>도서 정보</th>
	        		<th>대출일</th>
	        		<th>반납예정일</th>
	        		<th>반납완료일</th>
	        		<th>상태</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
	        		<c:when test="${empty bookHistoryList}">
	        			<td colspan="7" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty bookHistoryList}">
			            <c:forEach var="i" begin="0" end="${fn:length(bookHistoryList) - 1}" step="1">
			                <tr onclick="location.href='/public/books/${bookHistoryList[i].booksId}'">
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>
			                    	<img src="${bookHistoryList[i].imageLink}"
				                        alt="${bookHistoryList[i].title} 책 표지" width="50">
				                </td>
				                <td>${bookHistoryList[i].title}</td>
			                    <td><fmt:formatDate value="${bookHistoryList[i].loanDate}" pattern="yyyy-MM-dd" /></td>
			                    <td><fmt:formatDate value="${bookHistoryList[i].dueDate}" pattern="yyyy-MM-dd" /></td>
			                    <td><fmt:formatDate value="${bookHistoryList[i].returnedDate}" pattern="yyyy-MM-dd" /></td>
				                <td>
				                    <div class="d-flex flex-column gap-2">
				                    	<c:set var="status">${bookHistoryList[i].status}</c:set>  
				                    	<c:choose>
				                    		<c:when test="${status eq 0}">
				                    			<div class="badge text-bg-success">정상</div>
				                    		</c:when>
				                    		<c:when test="${status eq 1}">
				                    			<div class="badge text-bg-danger">연체</div>
				                    		</c:when>
				                    		<c:otherwise>
				                    			알 수 없음
				                    		</c:otherwise>
				                    	</c:choose>
				                    </div>
				                </td>
			                </tr>
			            </c:forEach>
			        </c:when>
		        </c:choose>
	        </tbody>
	    </table>
	    
	  	<c:choose>
        	<c:when test="${not empty bookHistoryList}">
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