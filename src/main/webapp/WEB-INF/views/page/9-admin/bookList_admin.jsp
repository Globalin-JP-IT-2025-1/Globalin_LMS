<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="bookList" value="${bookList}" />

<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPage}" />
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
.bookList td:nth-child(1), .bookList th:nth-child(1) { min-width: 50px !important; }
.bookList td:nth-child(2), .bookList th:nth-child(2) { min-width: 50px !important; }
.bookList td:nth-child(3), .bookList th:nth-child(3) { min-width: 100px !important; }
.bookList td:nth-child(4), .bookList th:nth-child(4) { min-width: 100px !important; }
.bookList td:nth-child(5), .bookList th:nth-child(5) { min-width: 50px !important; }
.bookList td:nth-child(6), .bookList th:nth-child(6) { min-width: 50px !important; }
.bookList td:nth-child(7), .bookList th:nth-child(7) { min-width: 100px !important; }
.bookList td:nth-child(8), .bookList th:nth-child(8) { min-width: 50px !important; }
.bookList td:nth-child(9), .bookList th:nth-child(9) { min-width: 50px !important; }
.bookList td:nth-child(10), .bookList th:nth-child(10) { min-width: 50px !important; }
.bookList td:nth-child(11), .bookList th:nth-child(11) { min-width: 50px !important; }

.bookList td:nth-child(1), .bookList th:nth-child(1) { max-width: 50px !important; }
.bookList td:nth-child(2), .bookList th:nth-child(2) { max-width: 50px !important; }
.bookList td:nth-child(3), .bookList th:nth-child(3) { max-width: 100px !important; }
.bookList td:nth-child(4), .bookList th:nth-child(4) { max-width: 100px !important; }
.bookList td:nth-child(5), .bookList th:nth-child(5) { max-width: 50px !important; }
.bookList td:nth-child(6), .bookList th:nth-child(6) { max-width: 50px !important; }
.bookList td:nth-child(7), .bookList th:nth-child(7) { max-width: 100px !important; }
.bookList td:nth-child(8), .bookList th:nth-child(8) { max-width: 50px !important; }
.bookList td:nth-child(9), .bookList th:nth-child(9) { max-width: 50px !important; }
.bookList td:nth-child(10), .bookList th:nth-child(10) { max-width: 50px !important; }
.bookList td:nth-child(11), .bookList th:nth-child(11) { max-width: 50px !important; }

</style>

<!-- 도서 통합검색 목록 조회 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
        	<form action="/admin/books" method="get" class="d-flex align-items-center gap-2">
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
    
    <!-- 도서 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover bookList">
	    	<thead>
	        	<tr>
	        		<th>NO</th>
	        		<th>ID</th>
	        		<th>도서 표지</th>
	        		<th>책제목</th>
	        		<th>저자</th>
	        		<th>발행자</th>
	        		<th>ISBN</th>
	        		<th>분류기호</th>
	        		<th>도서 상태</th>
	        		<th>대출/반납</th>
	        		<!-- <th>공개/비공개</th> -->
	        		<th>삭제</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
	        		<c:when test="${empty bookList}">
	        			<td colspan="6" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty bookList}">
			            <c:forEach var="i" begin="0" end="${fn:length(bookList) - 1}" step="1">
			                <tr>
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>${bookList[i].booksId}</td>
			                    <td>
				                    <img src="${bookList[i].imageLink}"
				                        alt="${bookList[i].title} 책 표지" width="50">
				                </td>
				                <td><div class="fw-bold col-10 text-truncate" onclick="location.href='/public/books/${bookList[i].booksId}'">${bookList[i].title}</div></td>
				                <td><div class="col-10 text-truncate">${bookList[i].author}</div></td>
		                       	<td><div>${bookList[i].publisher}</div></td>
		                        <td><div>${bookList[i].isbn}</div></td>
		                        <td><div>${bookList[i].category}</div></td>
				                
				                <td>
			                        <div class="mb-2 fw-semibold">
			                        	<c:set var="status">${bookList[i].status}</c:set>
			                        	<c:choose>
			                        		<c:when test="${status eq 0}">
			                        			<div class="badge text-bg-success">대출가능</div>
			                        		</c:when>
			                        		<c:when test="${status eq 1}">
			                        			<div class="badge text-bg-secondary">비공개</div>
			                        		</c:when>
			                        		<c:when test="${status eq 2}">
			                        			<div class="badge text-bg-warning">대출중</div>
			                        		</c:when>
			                        		<%-- <c:when test="${status eq 3}">
			                        			<div class="text-danger">대출 예약 중</div>
			                        		</c:when> --%>
			                        		<c:otherwise>
			                        			알 수 없음
			                        		</c:otherwise>
			                        	</c:choose>
			                        </div>
				                </td>
			                    <td>
			                    	<c:set var="status">${bookList[i].status}</c:set>
		                        	<c:choose>
		                        		<c:when test="${status eq 0}">
		                        			<!-- 대출가능 -->
											<button class="btn btn-sm btn-primary"
											        data-bs-toggle="modal"
											        data-bs-target="#loanModal"
											        onclick="setLoanFormAction(${bookList[i].booksId})">대출</button>
		                        		</c:when>
		                        		<c:when test="${status eq 1}">
		                        			<div class="text-secondary">비공개</div>
		                        		</c:when>
		                        		<c:when test="${status eq 2}">
		                        			<!-- 대출 중 -->
											<button class="btn btn-sm btn-success"
											        data-bs-toggle="modal"
											        data-bs-target="#returnModal"
											        onclick="setReturnFormAction(${bookList[i].booksId})">반납</button>
		                        		</c:when>
		                        		<c:otherwise>
		                        			알 수 없음
		                        		</c:otherwise>
		                        	</c:choose>
			                    </td>
			                    <%-- <td>
			                    	<!-- 비공개(1) ↔ 공개 전환 스위치 -->
									<form id="statusForm-${bookList[i].booksId}" method="post">
					                    <input type="hidden" name="_method" value="PUT" />
					                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                    <div class="form-check form-switch">
					                       	<input class="form-check-input" type="checkbox"  id="statusSwitch-${bookList[i].booksId}"
					                               ${bookList[i].status == 1 ? "" : "checked"}
						                           onchange="submitStatus('${article.articlesId}', '${bookList[i].booksId}')">
				                        </div>
				                  	</form>
			                    </td> --%>
			                    <td>
			                    	<form action="/admin/books/${bookList[i].booksId}" method="post" class="d-inline">
									  	<input type="hidden" name="_method" value="DELETE" />
									  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
											<i class="bi bi-trash"></i>
										</button>
									</form>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:when>
		        </c:choose>
	        </tbody>
	    </table>
	    
	    <!-- loan 모달 -->
		<div class="modal fade" id="loanModal" tabindex="-1" aria-labelledby="loanModalLabel" aria-hidden="true">
		  	<div class="modal-dialog">
		    	<div class="modal-content">
		      		<form method="post">
		        		<div class="modal-header">
		          			<h5 class="modal-title" id="loanModalLabel">도서 대출</h5>
		          			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
		        		</div>
		        		<div class="modal-body">
		          			<div class="mb-3">
		            			<label for="memberCard" class="form-label">회원카드 번호</label>
		            			<input type="text" class="form-control" name="cardNo" id="memberCard" required>
		          			</div>
		          			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		        		</div>
		        		<div class="modal-footer">
				          	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				          	<button type="submit" class="btn btn-primary">대출하기</button>
		        		</div>
		      		</form>
		    	</div>
		  	</div>
		</div>
	    
	    <!-- return 모달 -->
		<div class="modal fade" id="returnModal" tabindex="-1" aria-labelledby="returnModalLabel" aria-hidden="true">
		  	<div class="modal-dialog">
		    	<div class="modal-content">
		      		<form method="post">
		        		<div class="modal-header">
		          			<h5 class="modal-title" id="returnModalLabel">도서 반납</h5>
		          			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
		        		</div>
		        		<div class="modal-body">
		          			<div class="mb-3">
		            			<label for="memberCard" class="form-label">회원카드 번호</label>
		            			<input type="text" class="form-control" name="cardNo" id="memberCard" required>
		          			</div>
		          			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		        		</div>
		        		<div class="modal-footer">
				          	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				          	<button type="submit" class="btn btn-primary">반납하기</button>
		        		</div>
		      		</form>
		    	</div>
		  	</div>
		</div>
	    
	    <!-- 도서 추가하기 버튼 -->
	    <div class="d-flex justify-content-end">
   			<button class="btn btn-primary mb-6" onclick="location.href='/admin/books/add'">도서 추가</button>
	  	</div>
	    
	  	<c:choose>
        	<c:when test="${not empty bookList}">
			    <!-- 페이징 -->
			    <c:set var="hasSearch" value="${not empty searchType and not empty searchKeyword}" />
			    
			    <div class="d-flex justify-content-center mt-4">
				    <nav aria-label="Page navigation">
				        <ul class="pagination">
				
				            <!-- 이전 페이지 -->
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <c:choose>
				                        <c:when test="${hasSearch}">
				                            <a class="page-link"
				                               href="?searchType=${searchType}&searchKeyword=${searchKeyword}&page=${currentPage - 1}">
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
				                        <c:when test="${hasSearch}">
				                            <a class="page-link"
				                               href="?searchType=${searchType}&searchKeyword=${searchKeyword}&page=${i}">
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
				                        <c:when test="${hasSearch}">
				                            <a class="page-link"
				                               href="?searchType=${searchType}&searchKeyword=${searchKeyword}&page=${currentPage + 1}">
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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>  
<script>
	// 대출 처리
	function setLoanFormAction(bookId) {
	  	const form = document.querySelector('#loanModal form');
	  	form.action = '/admin/books/' + bookId + '/loan';
	}
	
	// 반납 처리
	function setReturnFormAction(bookId) {
	  	const form = document.querySelector('#returnModal form');
	  	form.action = '/admin/books/' + bookId + '/return';
	}
	
	// 공개 비공개
   	function submitStatus(bookId) {
      	const isChecked = document.getElementById("statusSwitch-" + bookId).checked;
      	const status = isChecked ? 0 : 1;
     
      	if (!bookId) {
	        alert("경로 생성 실패: bookId가 비어있습니다.");
	        return;
     	}
   
       	const form = document.getElementById("statusForm-" + bookId);
        form.action = '/admin/books/' + bookId + '/' + status;
        form.submit();
   	}
</script>

