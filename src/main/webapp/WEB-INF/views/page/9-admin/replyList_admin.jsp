<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="replyList" value="${replyList}" />
<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<style>
.replyList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.replyList td, .replyList th {
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
}

/* 각 열 너비 */
.replyList td:nth-child(1), .replyList th:nth-child(1) { min-width: 4% !important; }
.replyList td:nth-child(2), .replyList th:nth-child(2) { min-width: 4% !important; }
.replyList td:nth-child(3), .replyList th:nth-child(3) { min-width: 8% !important; }
.replyList td:nth-child(4), .replyList th:nth-child(4) { min-width: 8% !important; }
.replyList td:nth-child(5), .replyList th:nth-child(5) { min-width: 30% !important; }
.replyList td:nth-child(6), .replyList th:nth-child(6) { min-width: 14% !important; }
.replyList td:nth-child(7), .replyList th:nth-child(7) { min-width: 8% !important; }
.replyList td:nth-child(8), .replyList th:nth-child(8) { min-width: 8% !important; }
.replyList td:nth-child(9), .replyList th:nth-child(9) { min-width: 8% !important; }
.replyList td:nth-child(10), .replyList th:nth-child(10) { min-width: 8% !important; }

.replyList td:nth-child(1), .replyList th:nth-child(1) { max-width: 4% !important; }
.replyList td:nth-child(2), .replyList th:nth-child(2) { max-width: 4% !important; }
.replyList td:nth-child(3), .replyList th:nth-child(3) { max-width: 8% !important; }
.replyList td:nth-child(4), .replyList th:nth-child(4) { max-width: 8% !important; }
.replyList td:nth-child(5), .replyList th:nth-child(5) { max-width: 30% !important; }
.replyList td:nth-child(6), .replyList th:nth-child(6) { max-width: 14% !important; }
.replyList td:nth-child(7), .replyList th:nth-child(7) { max-width: 8% !important; }
.replyList td:nth-child(8), .replyList th:nth-child(8) { max-width: 8% !important; }
.replyList td:nth-child(9), .replyList th:nth-child(9) { max-width: 8% !important; }
.replyList td:nth-child(10), .replyList th:nth-child(10) { max-width: 8% !important; }

</style>

<!-- 댓글 & 북 리뷰 목록 조회 - 관리자 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
	        <form action="/admin/replies" method="get" class="d-flex align-items-center gap-2">
				<select class="form-select form-select-sm w-auto" name="searchType">
				    <option value="content">내용</option>
				    <option value="author">작성자</option>
			  	</select>
				<input type="text" class="form-control form-control-sm w-auto" name="searchKeyword" placeholder="검색어 입력">
				<button type="submit" class="btn btn-primary btn-sm">검색</button>
			</form>
	    </div>
    </div>
    
    <!-- 글 목록 -->
    <div class="container" >
	    <table class="table mt-3 table-hover overflow-x-auto replyList">
	        <thead class="table-primary">
	            <tr>
	                <th>NO</th>
	                <th>댓글 ID</th>
	                <th>내용</th>
	                <th>작성자</th>
	                <th>작성날짜(수정날짜)</th>
	                <th>상태</th>
	                <th>삭제</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${empty replyList}">
	        			<td colspan="9" style="text-align: center;">조회된 댓글이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty replyList}">
			            <c:forEach var="i" begin="0" end="${fn:length(replyList) - 1}" step="1">
			                <tr>
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>${replyList[i].repliesId}</td>         
			                    <td>${replyList[i].content}</td>         
			                    <td>
			                    	${replyList[i].authorFullname}
			                    	(${replyList[i].authorUsername})
			                    </td>
			                    <td>
			                    	<fmt:formatDate value="${replyList[i].createDate}" pattern="yyyy-MM-dd" /><br>
			                    	(<fmt:formatDate value="${replyList[i].updateDate}" pattern="yyyy-MM-dd" />)
			                    </td>
			                    <td>
			                    	<c:choose>
			                    		<c:when test="${replyList[i].status eq 0}">
			                    			공개글
			                    		</c:when>
			                    		<c:when test="${replyList[i].status eq 1}">
			                    			비공개글
			                    		</c:when>
			                    		<c:when test="${replyList[i].status eq 2}">
			                    			비밀글
			                    		</c:when>
			                    		<c:otherwise>
			                    			알 수 없음
			                    		</c:otherwise>
			                    	</c:choose>
			                    </td>
			                    <td><a href="#">삭제</a></td>
			                </tr>
			            </c:forEach>
			        </c:when>
			    </c:choose>
	        </tbody>
	    </table>
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