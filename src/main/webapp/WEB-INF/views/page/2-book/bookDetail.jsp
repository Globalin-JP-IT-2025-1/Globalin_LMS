<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="book" value="${book}" />
<c:set var="reviewList" value="${reviewList}" />

<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/articleDetail.css">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="row g-0 align-items-center">
                    <div class="col-md-4 text-center">
                        <img src="${book.imageLink}"
				           	alt="${book.title} 책 표지" width="200">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <div class="text-secondary mb-1">
                            	총류 > 총류
                            	${book.category}
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
                <div class="text-danger fw-semibold">대출중</div>
                <button class="btn btn-secondary btn-sm" disabled>도서예약불가</button>
                <button class="btn btn-outline-success btn-sm">관심도서담기</button>
            </div>
            <div>
                <div class="text-secondary">도서상세정보 보기</div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid mb-5 card articleDetail_div2">   
	<label class="form-label mt-4 mb-3">댓글(전체 <strong>${fn:length(reviewList)}</strong> 건)</label>
	<!-- 댓글 작성 폼 -->
	<div class="articleDetail_div3">
		<form action="/private/reviews/${articlesId}/not" method="post">
			<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			<c:choose>
				<c:when test="${not empty userDetails}">
					<div class="reviews_writebox position-relative">
						<div class="position-relative w-100">
							<textarea class="form-control" name="content" id="replyContent" maxlength="500" rows="3"></textarea><!-- 댓글 작성 - 서버 송신1 -->
							<div class="char-count-inside" id="charCount">0 / 500</div>
							<sec:authorize access="hasRole('ROLE_USER')">
								<input type="hidden" name="authorId" value="${userDetails.membersId}" readonly><!-- 댓글 작성 - 서버 송신2 -->
							</sec:authorize>
						</div>
						<button class="btn btn-outline-primary addBtn" type="submit">등록</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="reviews_writebox position-relative">
						<div class="position-relative w-100">
							<textarea class="form-control bg-light" id="replyContent" maxlength="500" rows="3" readonly>로그인 필요</textarea>
							<div class="char-count-inside" id="charCount">0 / 500</div>
						</div>
						<button class="btn btn-outline-secondary addBtn" type="submit" disabled>등록불가</button>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
      
		<hr class="border border-1 opacity-50">
	</div>
   
	<div class="articleDetail_div4">   
		<!-- 리뷰 목록 조회 -->
		<c:if test="${not empty reviewList}">
			<div class="position-relative mt-2 mb-4">
				<c:forEach var="i" begin="0" end="${fn:length(reviewList) - 1}" step="1">
					<div class="d-flex justify-content-between align-items-center mb-2" style="position: relative;">
						<div>
							<!-- 리뷰 작성자 -->
							<label class="form-label replyLabel">
								<c:set var="r_fullname" value="${reviewList[i].authorFullname}" />
		                    	<c:set var="r_username" value="${reviewList[i].authorUsername}" />
		                    	<!-- 로그인하지 않은 경우 -->
			                    <sec:authorize access="isAnonymous()">
									<c:choose>
			                    		<c:when test="${r_username eq 'admin'}">
			                    			${r_fullname}(${r_username})
			                    		</c:when>
			                    		<c:otherwise>
											${fn:substring(r_fullname, 0, 1)}**(${r_username})
			                    		</c:otherwise>
			                    	</c:choose>
			                    </sec:authorize>
			                    <!-- 로그인한 경우 -->
			                    <sec:authorize access="isAuthenticated()">
			                       	<c:choose>
			                          	<c:when test="${reviewList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">                     
			                            	${r_fullname}(${r_username})
			                            </c:when>
			                            <c:otherwise>
											${fn:substring(r_fullname, 0, 1)}**(${r_username})
			                            </c:otherwise>
			                         </c:choose>
			                    </sec:authorize>
			                </label>
	                       
	                       	<!-- 리뷰 내용: status=2(게스트인 경우와 작성자가 아닌 경우 비공개, 작성자와 관리자인 경우 공개), 0(전체 공개), 1(가져오지 않음) -->
	                       	<label class="form-label">
		                       	<c:choose>
		                            <c:when test="${reviewList[i].status == 0}">
			                    		<span class="text-dark">${reviewList[i].content}</span>
			                    	</c:when>
			                    	
		                            <c:when test="${reviewList[i].status == 2}">
		                            	<sec:authorize access="isAnonymous()">
				                            <span class="text-secondary"><i class="bi bi-lock"></i>&nbsp;비공개 댓글입니다.</span>
				                        </sec:authorize>
				                        <sec:authorize access="isAuthenticated()">
		                            		<c:choose>
		                            			<c:when test="${reviewList[i].authorId != userDetails.membersId}">
						                            <span class="text-secondary"><i class="bi bi-lock"></i>&nbsp;비공개 댓글입니다.</span>
		                            			</c:when>
		                            			<c:when test="${reviewList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">
						                    		<span class="text-dark">${reviewList[i].content}</span>
		                            			</c:when>
		                            		</c:choose>
		                            	</sec:authorize>
			                    	</c:when>
			                    </c:choose>
	                     	</label>
	                     	
	                     	<!-- 작성날짜: 월.일 시:초 -->
							<label class="form-label replyLabel">
								<fmt:formatDate value="${reviewList[i].updateDate}" pattern="MM.dd hh:mm:ss" />
							</label>
						</div>
						
						<!-- 리뷰 비밀↔공개 전환 스위치 + 삭제 버튼 : 현재 로그인한 사용자와 댓글 작성자가 일치하는 경우 또는 관리자만 공개 -->
						<sec:authorize access="isAuthenticated()">
				            <c:if test="${reviewList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">
								
								<!-- 오른쪽 스위치 + 삭제 버튼 -->
								<div class="d-flex align-items-center" style="gap: 10px;">
									<!-- 리뷰 비밀↔공개 스위치 폼 -->
									<form id="statusForm-${reviewList[i].bookReviewsId}" method="post">
					                    <input type="hidden" name="_method" value="PUT" />
					                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                    <div class="form-check form-switch">
					                       	<input class="form-check-input" type="checkbox"  id="statusSwitch-${reviewList[i].bookReviewsId}"
					                               ${reviewList[i].status == 2 ? "" : "checked"}
						                           onchange="submitStatus('${book.booksId}', '${reviewList[i].bookReviewsId}')">
				                        </div>
				                  	</form>
				                  	
				                   	<!-- 리뷰 삭제 버튼 (soft del) -->
					                <form action="/private/reviews/${book.booksId}/${reviewList[i].bookReviewsId}/1" method="post">
					                    <input type="hidden" name="_method" value="PUT" />
					                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                    <button type="submit" class="hideBtn"><i class="bi bi-trash3"></i></button>
					                </form>
				               	</div>
				            </c:if>
			            </sec:authorize>
	            	</div>
	            	<hr class="border opacity-50">
	           	</c:forEach>
	        </div>
	        
	        <!-- 북 리뷰 페이징 -->
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
		</c:if>
	</div>
</div>
