<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="articleList" value="${articleListWithAuthor}" />
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
</style>

<!-- 게시글 목록 조회 - 관리자 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
	        <select class="form-select form-select-sm d-inline-block w-auto" id="searchType">
	            <option id="st_title">제목</option>
	            <option id="st_content">내용</option>
	        </select>
	        <input type="text" class="form-control form-control-sm d-inline-block w-auto" id="searchKeyword">
	        <button class="btn btn-primary btn-sm" id="search">검색</button>
	    </div>
    </div>
    
    <!-- 글 목록 -->
    <div class="overflow-x-auto" >
	    <table class="table mt-3 table-hover articleList">
	        <thead class="table-primary">
	            <tr>
	                <th>NO</th>
	                <th>게시글 ID</th>
	                <th>카테고리</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>작성날짜(수정날짜)</th>
	                <th>조회수</th>
	                <th>댓글수</th>
	                <th>상태</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="i" begin="0" end="${fn:length(articleList) - 1}" step="1">
	                <tr onclick="location.href='/public/articles/${articleList[i].category}/${articleList[i].articlesId}'">
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
	                    	${articleList[i].category}
	                    </td>         
	                    <td>${articleList[i].title}</td>         
	                    <td>
	                    	${articleList[i].authorFullname}
	                    	(${articleList[i].authorUsername})
	                    </td>
	                    <td>
	                    	<fmt:formatDate value="${articleList[i].createDate}" pattern="yyyy-MM-dd" />
	                    	(<fmt:formatDate value="${articleList[i].updateDate}" pattern="yyyy-MM-dd" />)
	                    </td>
	                    <td>${articleList[i].viewCount}</td>
	                    <td>${articleList[i].replyCount}</td>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${articleList[i].status eq 0}">
	                    			공개글
	                    		</c:when>
	                    		<c:when test="${articleList[i].status eq 1}">
	                    			비공개글
	                    		</c:when>
	                    		<c:when test="${articleList[i].status eq 2}">
	                    			비밀글
	                    		</c:when>
	                    		<c:otherwise>
	                    			알 수 없음
	                    		</c:otherwise>
	                    	</c:choose>
	                    </td>
	                </tr>
	            </c:forEach>
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