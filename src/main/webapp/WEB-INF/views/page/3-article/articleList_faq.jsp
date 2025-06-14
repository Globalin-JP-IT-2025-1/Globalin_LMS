<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="faqList" value="${faqList}" />

<!-- 게시글 목록 조회 - 자주 묻는 질문 -->
<!-- 질문 -->
<!-- ㄴ 답변  (기본: 숨기기, 원본글 누르면: 펼치기)-->

<div class="container mt-5">
  <div class="accordion" id="faqAccordion">
  	<c:forEach var="faq" items="faqList">
  	<c:set var="cnt" value="cnt + 1" />
	    <!-- 질문 1 -->
	    <div class="accordion-item">
	      <h2 class="accordion-header">
	        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
	        	<span>질문 ${cnt}.</span><span>${faqList.question}</span>
	        </button>
	      </h2>
	      <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
	        <div class="accordion-body">
	        	${faqList.answer}
	        </div>
	      </div>
	    </div>
	
	</c:forEach>
    
  </div>
</div>

