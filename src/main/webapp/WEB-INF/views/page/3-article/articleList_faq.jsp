<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="articleList" value="${articleList}" />

<!-- 게시글 목록 조회 - 자주 묻는 질문 -->
<!-- 질문 -->
<!-- ㄴ 답변  (기본: 숨기기, 원본글 누르면: 펼치기)-->


<!-- <h2>[자주 묻는 질문] 게시글 목록 조회</h2> -->
<div class="container mt-5">
  <div>전체 <strong>${fn:length(articleList)}</strong> 건</div>
  <div class="accordion" id="faqAccordion">
  	<c:forEach var="article" items="${articleList}" varStatus="status">
  	<c:set var="cnt" value="${status.index + 1}" />
	    <!-- 질문 1 -->
	    <div class="accordion-item">
	      <h2 class="accordion-header">
	        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq${cnt}">
	        <span>질문 ${cnt}.</span><span>${article.title}</span>
	        <!-- 	질문 1 -->
	        </button>
	      </h2>
	      <div id="faq${cnt}" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
	        <div class="accordion-body">
	        	${article.content}
	        	<!-- 답변 1 -->
	        </div>
	      </div>
	    </div>	
	</c:forEach>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.min.js" 
		integrity="sha384-RuyvpeZCxMJCqVUGFI0Do1mQrods/hhxYlcVfGPOfQtPJh0JCw12tUAZ/Mv10S7D" 
		crossorigin="anonymous"></script>

