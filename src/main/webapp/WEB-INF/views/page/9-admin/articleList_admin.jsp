<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="articleList" value="${articleList}" />
<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<style>
.articleList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.articleList td, .articleList th {
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
}

/* 각 열 너비 */
.articleList td:nth-child(1), .articleList th:nth-child(1) { min-width: 50px !important; }
.articleList td:nth-child(2), .articleList th:nth-child(2) { min-width: 50px !important; }
.articleList td:nth-child(3), .articleList th:nth-child(3) { min-width: 80px !important; }
.articleList td:nth-child(4), .articleList th:nth-child(4) { min-width: 120px !important; }
.articleList td:nth-child(5), .articleList th:nth-child(5) { min-width: 80px !important; }
.articleList td:nth-child(6), .articleList th:nth-child(6) { min-width: 100px !important; }
.articleList td:nth-child(7), .articleList th:nth-child(7) { min-width: 50px !important; }
.articleList td:nth-child(8), .articleList th:nth-child(8) { min-width: 50px !important; }
.articleList td:nth-child(9), .articleList th:nth-child(9) { min-width: 50px !important; }
.articleList td:nth-child(10), .articleList th:nth-child(10) { min-width: 50px !important; }

.articleList td:nth-child(1), .articleList th:nth-child(1) { max-width: 50px !important; }
.articleList td:nth-child(2), .articleList th:nth-child(2) { max-width: 50px !important; }
.articleList td:nth-child(3), .articleList th:nth-child(3) { max-width: 80px !important; }
.articleList td:nth-child(4), .articleList th:nth-child(4) { max-width: 120px !important; }
.articleList td:nth-child(5), .articleList th:nth-child(5) { max-width: 80px !important; }
.articleList td:nth-child(6), .articleList th:nth-child(6) { max-width: 100px !important; }
.articleList td:nth-child(7), .articleList th:nth-child(7) { max-width: 50px !important; }
.articleList td:nth-child(8), .articleList th:nth-child(8) { max-width: 50px !important; }
.articleList td:nth-child(9), .articleList th:nth-child(9) { max-width: 50px !important; }
.articleList td:nth-child(10), .articleList th:nth-child(10) { max-width: 50px !important; }

</style>

<!-- 게시글 목록 조회 - 관리자 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
        	<form action="/public/books/total" method="get" class="d-flex align-items-center gap-2">
				<select class="form-select form-select-sm w-auto" name="searchType">
				    <option value="all">전체</option>
				    <option value="title">제목</option>
				    <option value="content">내용</option>
				    <option value="author">작성자</option>
			  	</select>
				<input type="text" class="form-control form-control-sm w-auto" name="searchKeyword" placeholder="검색어 입력">
				<button type="submit" class="btn btn-primary btn-sm">검색</button>
			</form>
	    </div>
    </div>
    
    <!-- 글 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover articleList">
	        <thead>
	            <tr>
	                <th>NO</th>
	                <th>ID</th>
	                <th>카테고리</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>작성날짜<br>(수정날짜)</th>
	                <th>조회수</th>
	                <th>댓글수</th>
	                <th>상태</th>
	                <th>삭제</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${empty articleList}">
	        			<td colspan="9" style="text-align: center;">조회된 게시글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty articleList}">
			            <c:forEach var="i" begin="0" end="${fn:length(articleList) - 1}" step="1">
					        <tr>
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>${articleList[i].articlesId}</td>         
			                    <td>
			                    	<c:choose>
			                    		<c:when test="${articleList[i].category eq 'not'}">
			                    			공지사항
			                    		</c:when>
			                    		<c:when test="${articleList[i].category eq 'faq'}">
			                    			자주 묻는 질문
			                    		</c:when>
			                    		<c:when test="${articleList[i].category eq 'qna'}">
			                    			Q&A
			                    		</c:when>
			                    		<c:when test="${articleList[i].category eq 'req'}">
			                    			희망 도서 신청
			                    		</c:when>
			                    		<c:otherwise>
			                    			알 수 없음
			                    		</c:otherwise>
			                    	</c:choose>
			                    </td>    
			                    
			                    <c:choose>
					            	<c:when test="${articleList[i].category eq 'req'}">
						                <td>
					            			<div class="fw-bold col-10 text-truncate" 
					            				 onclick="location.href='/private/articles/req/${articleList[i].articlesId}'">
					            				${articleList[i].title}
					            			</div>
					            		</td>
					            	</c:when>
					            	<c:otherwise>
					            		<td>
					            			<div class="fw-bold col-10 text-truncate" 
					            				 onclick="location.href='/public/articles/${articleList[i].category}/${articleList[i].articlesId}'">
					            				${articleList[i].title}
					            			</div>
					            		</td>
					            	</c:otherwise>
			            		</c:choose>
			            		
			                    <td>
			                    	${articleList[i].authorFullname}
			                    	(${articleList[i].authorUsername})
			                    </td>
			                    <td>
			                    	<fmt:formatDate value="${articleList[i].createDate}" pattern="yyyy-MM-dd" /><br>
			                    	(<fmt:formatDate value="${articleList[i].updateDate}" pattern="yyyy-MM-dd" />)
			                    </td>
			                    <td>${articleList[i].viewCount}</td>
			                    <td>${articleList[i].replyCount}</td>
			                    <td>
			                    	<c:choose>
			                    		<c:when test="${articleList[i].status eq 0}">
			                    			<div class="badge text-bg-success">공개</div>
			                    		</c:when>
			                    		<c:when test="${articleList[i].status eq 1}">
			                    			<div class="badge text-bg-secondary">비공개</div>
			                    		</c:when>
			                    		<c:when test="${articleList[i].status eq 2}">
			                    			<div class="badge text-bg-warning">비밀</div>
			                    		</c:when>
			                    		<c:otherwise>
			                    			알 수 없음
			                    		</c:otherwise>
			                    	</c:choose>
			                    </td>
			                    
			                    <td>
			                    	<form action="/admin/articles/${articleList[i].articlesId}" method="post" class="d-inline">
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
    </div>
    
    <!-- 글 작성하기 버튼 : 관리자만 보이기 -->
    <div class="d-flex justify-content-end">
   		<button class="btn btn-primary mb-6" onclick="location.href='/admin/articles/not/add'">작성하기</button>
  	</div>
    
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
</div>