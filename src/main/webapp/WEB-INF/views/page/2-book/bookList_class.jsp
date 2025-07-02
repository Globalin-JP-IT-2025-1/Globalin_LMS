<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

.bookSearchClass a:hover {
	text-decoration: underline !important;
}

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

.bookList td:nth-child(1), .bookList th:nth-child(1) { max-width: 5% !important; }
.bookList td:nth-child(2), .bookList th:nth-child(2) { max-width: 10% !important; }
.bookList td:nth-child(3), .bookList th:nth-child(3) { max-width: 65% !important; }
.bookList td:nth-child(4), .bookList th:nth-child(4) { max-width: 10% !important; }
.bookList td:nth-child(5), .bookList th:nth-child(5) { max-width: 5% !important; }
.bookList td:nth-child(6), .bookList th:nth-child(6) { max-width: 5% !important; }

</style>

<div class="container">
	<div class="container py-4">
	  	<div class="row row-cols-2 row-cols-md-5 g-3 text-center">
		    <div class="col">
				<a href="/public/books/class?class_no=0" class="btn btn-light border w-100 py-4">
				 	<i class="fas fa-book fa-2x mb-2"></i><br>총류
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=1" class="btn btn-light border w-100 py-4">
					<i class="fas fa-brain fa-2x mb-2"></i><br>철학
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=2" class="btn btn-light border w-100 py-4">
					<i class="fas fa-dove fa-2x mb-2"></i><br>종교
				</a>
		    </div>
		    <div class="col">
		     	<a href="/public/books/class?class_no=3" class="btn btn-light border w-100 py-4">
		    		<i class="fas fa-people-arrows fa-2x mb-2"></i><br>사회과학
		     	</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=4" class="btn btn-light border w-100 py-4">
					<i class="fas fa-flask fa-2x mb-2"></i><br>자연과학
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=5" class="btn btn-light border w-100 py-4">
					<i class="fas fa-tools fa-2x mb-2"></i><br>기술과학
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=6" class="btn btn-light border w-100 py-4">
					<i class="fas fa-paint-brush fa-2x mb-2"></i><br>예술
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=7" class="btn btn-light border w-100 py-4">
					<i class="fas fa-language fa-2x mb-2"></i><br>언어
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=8" class="btn btn-light border w-100 py-4">
					<i class="fas fa-book-open fa-2x mb-2"></i><br>문학
				</a>
		    </div>
		    <div class="col">
				<a href="/public/books/class?class_no=9" class="btn btn-light border w-100 py-4">
					<i class="fas fa-landmark fa-2x mb-2"></i><br>역사
				</a>
		    </div>
	  	</div>
	</div>
</div>

<!-- 도서 목록 -->
<div class="container mt-4">
	<!-- 요약 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
    </div>
    
    <!-- 도서 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover bookList">
	    	<thead class="table-primary">
	        	<tr>
	        		<th>NO</th>
	        		<th>도서 표지</th>
	        		<th>도서 정보</th>
	        		<th>도서 상태</th>
	        		<th>조회수</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
	        		<c:when test="${empty bookList}">
	        			<td colspan="6" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty bookList}">
			            <c:forEach var="i" begin="0" end="${fn:length(bookList) - 1}" step="1">
			                <tr onclick="location.href='/public/books/${bookList[i].booksId}'">
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>
									<img 
									    src="${bookList[i].imageLink}" 
									    alt="${bookList[i].title} 책 표지" 
									    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/images/default.png';"
									    style="height: 100px; object-fit: cover;" 
									    class="img-fluid rounded border">
				                </td>
				                <td>
				                    <div class="text-secondary mb-1">
				                    	${bookList[i].category}
				                    	<c:set var="cat" value="${bookList[i].category}" /> 
				                    	<c:choose>
											<c:when test="${fn:startsWith(cat, '0')}">총류</c:when>
											<c:when test="${fn:startsWith(cat, '1')}">철학</c:when>
											<c:when test="${fn:startsWith(cat, '2')}">종교</c:when>
											<c:when test="${fn:startsWith(cat, '3')}">사회과학</c:when>
											<c:when test="${fn:startsWith(cat, '4')}">자연과학</c:when>
											<c:when test="${fn:startsWith(cat, '5')}">기술과학</c:when>
											<c:when test="${fn:startsWith(cat, '6')}">예술</c:when>
											<c:when test="${fn:startsWith(cat, '7')}">언어</c:when>
											<c:when test="${fn:startsWith(cat, '8')}">문학</c:when>
											<c:when test="${fn:startsWith(cat, '9')}">역사</c:when>
											<c:otherwise>기타</c:otherwise>
										</c:choose>
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
				                    <div class="d-flex flex-column justify-center">
			                        	<c:set var="status">${bookList[i].status}</c:set>
		                        		<c:choose>
			                        		<c:when test="${status eq 0}">
			                        			<div class="text-success">대출가능</div>
			                        		</c:when>
			                        		<c:when test="${status eq 1}">
			                        			<div class="text-secondary">비공개</div>
			                        		</c:when>
			                        		<c:when test="${status eq 2}">
			                        			<div class="text-info">대출 중(예약 가능)</div>
			                        		</c:when>
			                        		<c:when test="${status eq 3}">
			                        			<div class="text-danger">대출 예약 중</div>
			                        		</c:when>
			                        		<c:otherwise>
			                        			알 수 없음
			                        		</c:otherwise>
			                        	</c:choose>
				                    </div>
				                </td>
			                    <td>${bookList[i].viewCount}</td>
			                </tr>
			            </c:forEach>
			        </c:when>
		        </c:choose>
	        </tbody>
	    </table>
	    
	  	<c:choose>
        	<c:when test="${not empty bookList}">
			    <!-- 페이징 -->
			    <c:set var="hasClassNo" value="${not empty classNo and classNo != '0'}" />

				<div class="d-flex justify-content-center mt-4">
				    <nav aria-label="Page navigation">
				        <ul class="pagination">
				
				            <!-- 이전 페이지 -->
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <c:choose>
				                        <c:when test="${hasClassNo}">
				                            <a class="page-link"
				                               href="?class_no=${classNo}&page=${currentPage - 1}">
				                                이전
				                            </a>
				                        </c:when>
				                        <c:otherwise>
				                            <a class="page-link" href="?page=${currentPage - 1}">이전</a>
				                        </c:otherwise>
				                    </c:choose>
				                </li>
				            </c:if>
				
				            <!-- 페이지 번호 -->
				            <c:forEach var="i" begin="${startPage}" end="${endPage}">
				                <li class="page-item ${i == currentPage ? 'active' : ''}">
				                    <c:choose>
				                        <c:when test="${hasClassNo}">
				                            <a class="page-link"
				                               href="?class_no=${classNo}&page=${i}">
				                                ${i}
				                            </a>
				                        </c:when>
				                        <c:otherwise>
				                            <a class="page-link" href="?page=${i}">${i}</a>
				                        </c:otherwise>
				                    </c:choose>
				                </li>
				            </c:forEach>
				
				            <!-- 다음 페이지 -->
				            <c:if test="${currentPage < totalPages}">
				                <li class="page-item">
				                    <c:choose>
				                        <c:when test="${hasClassNo}">
				                            <a class="page-link"
				                               href="?class_no=${classNo}&page=${currentPage + 1}">
				                                다음
				                            </a>
				                        </c:when>
				                        <c:otherwise>
				                            <a class="page-link" href="?page=${currentPage + 1}">다음</a>
				                        </c:otherwise>
				                    </c:choose>
				                </li>
				            </c:if>
				        </ul>
				    </nav>
				</div>

			</c:when>
		</c:choose>
    </div>
</div>
