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

<!-- 게시글 목록 조회 - 자주 묻는 질문 -->
<!-- 질문 -->
<!-- ㄴ 답변  (기본: 숨기기, 원본글 누르면: 펼치기)-->
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${fn:length(articleList)}</strong> 건</div>
        <div>
	        <select class="form-select form-select-sm d-inline-block w-auto" id="searchType">
	            <option id="st_title">제목</option>
	            <option id="st_content">내용</option>
	        </select>
	        <input type="text" class="form-control form-control-sm d-inline-block w-auto" id="searchKeyword">
	        <button class="btn btn-primary btn-sm" id="search">검색</button>
	    </div>
    </div>
    
    <div class="accordion mt-3" id="faqAccordion">
	  	<c:forEach var="i" begin="0" end="${fn:length(articleList) - 1}" step="1">
		    <!-- 질문 1 -->
		    <div class="accordion-item">
		      	<h2 class="accordion-header">
		        	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq${i + (currentPage * 7) - 6}">
		       		<span>질문 ${i + (currentPage * 7) - 6}.&nbsp;</span><span>${articleList[i].title}</span>
		        	</button>
		      	</h2>
	      		<div id="faq${i + (currentPage * 7) - 6}" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
			        <div class="accordion-body">
			        	${articleList[i].content}
			        </div>
		      	</div>
		    </div>	
		</c:forEach>
  	</div>
  
	<!-- 글 작성하기 버튼 : 관리자만 보이기 -->
    <div class="d-flex justify-content-end">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
   			<button class="btn btn-primary mb-6" onclick="location.href='/admin/articles/faq/add'">작성하기</button>
	  	</sec:authorize>
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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.min.js"></script>

