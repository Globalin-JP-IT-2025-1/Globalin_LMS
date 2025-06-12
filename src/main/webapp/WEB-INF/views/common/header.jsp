<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">
<c:set var="h_membersId" value="${sessionScope.currentMember.membersId}" /> 
<c:set var="h_username" value="${sessionScope.currentMember.username}" /> 
<c:set var="h_name" value="${sessionScope.currentMember.name}" />
<!-- 최상단 header 구조 - 부트스트랩 스타일 적용 -->

<div class="container-fluid border-bottom py-4 bg-white">
  <div class="container d-flex justify-content-between align-items-center">
    <div class="d-flex align-items-center">
      <i class="bi bi-globe fs-2 me-3"></i>
      <div class="btn-group btn-group-sm" role="group" aria-label="Language selector">
        <button type="button" class="btn btn-primary active lang-btn" id="kr">한글</button>
        <button type="button" class="btn btn-outline-secondary lang-btn" id="jp">日本語</button>
        <button type="button" class="btn btn-outline-secondary lang-btn" id="en">English</button>
      </div>
    </div>

    <div class="text-center">
      <a href="/">
        <img src="${pageContext.request.contextPath}/resources/images/title.png" alt="globalin-library" class="img-fluid" style="max-height: 80px;">
      </a>
    </div>

    <div class="text-end">
      <div class="d-flex justify-content-end gap-2 align-items-center h_mini_menu">
        <a href="/" class="fw-semibold"><spring:message code="menu.0.title" /></a>
        <span>|</span>
        <c:choose>
          <c:when test="${empty h_membersId}">
            <a href="/public/auth/login" class="fw-semibold"><spring:message code="menu.6.con1" /></a>
            <span>|</span>
            <a href="/public/members/register" class="fw-semibold"><spring:message code="menu.6.con4" /></a>
            <span>|</span>
          </c:when>
          <c:otherwise>
            <form action="/private/auth/logout/${h_membersId}" method="post" class="d-inline">
              <input type="submit" value="<spring:message code='h.minimenu.logout' />" id="logoutBtn" class="btn btn-link p-0 fw-semibold">
            </form>
            <span>|</span>
          </c:otherwise>
        </c:choose>
        <a href="/public/etc/71" class="fw-semibold"><spring:message code="menu.7.con1" /></a>
      </div>
      <c:if test="${not empty h_membersId}">
        <div class="mt-1 px-3 py-1 bg-light rounded">
          <a href="/private/members/${h_membersId}" id="mypage" class="fw-bold text-decoration-none">
            <c:out value="${h_name}" />(<c:out value="${h_username}" />)
          </a>
          <spring:message code="h.welcome.message" />
        </div>
      </c:if>
    </div>
  </div>
</div>

<!-- 메인 메뉴 바 -->
<nav class="navbar navbar-expand-lg navbar-main border-top border-bottom py-2">
  <div class="container">
    <div class="collapse navbar-collapse show">
      	<ul class="navbar-nav me-auto mb-2 mb-lg-0 d-flex align-items-center gap-3">
	        <li class="nav-item">
	          <button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_1_toggle"><spring:message code="menu.1.title" /></button>
	        </li>
	        <li class="nav-item">
	          <button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_2_toggle"><spring:message code="menu.2.title" /></button>
	        </li>
	        <li class="nav-item">
	          <button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_3_toggle"><spring:message code="menu.4.title" /></button>
	        </li>
	        <li class="nav-item">
	          <button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_4_toggle"><spring:message code="menu.5.title" /></button>
	        </li>
	        <li class="nav-item">
	          <button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_5_toggle"><spring:message code="menu.3.title" /></button>
	        </li>
   		</ul>
      	<div class="position-absolute w-100 hidden shadow-sm" id="h_submenu">
		  <div class="container py-4">
		    <div class="row row-cols-1 row-cols-md-5 g-4">
		      <div class="col">
		        <ul class="list-unstyled">
		          <li><a href="/public/books/total"><spring:message code="menu.1.con1" /></a></li>
		          <li><a href="/public/books/class"><spring:message code="menu.1.con2" /></a></li>
		          <li><a href="/public/books/loan"><spring:message code="menu.1.con3" /></a></li>
		          <li><a href="/public/books/like"><spring:message code="menu.1.con4" /></a></li>
		        </ul>
		      </div>
		      <div class="col">
		        <ul class="list-unstyled">
		          <li><a href="/public/articles/notice"><spring:message code="menu.2.con1" /></a></li>
		          <li><a href="/public/articles/fnq"><spring:message code="menu.2.con2" /></a></li>
		          <li><a href="/public/articles/qna"><spring:message code="menu.2.con3" /></a></li>
		          <li><a href="/private/articles/req"><spring:message code="menu.2.con4" /></a></li>
		        </ul>
		      </div>
		      <div class="col">
		        <ul class="list-unstyled">
		          <li><a href="/public/etc/41"><spring:message code="menu.4.con1" /></a></li>
		          <li><a href="/public/etc/42"><spring:message code="menu.4.con2" /></a></li>
		          <li><a href="/public/etc/43"><spring:message code="menu.4.con3" /></a></li>
		        </ul>
		      </div>
		      <div class="col">
		        <ul class="list-unstyled">
		          <li><a href="/public/etc/51"><spring:message code="menu.5.con1" /></a></li>
		          <li><a href="/public/etc/52"><spring:message code="menu.5.con2" /></a></li>
		          <li><a href="/public/etc/53"><spring:message code="menu.5.con3" /></a></li>
		        </ul>
		      </div>
		      <div class="col">
		        <ul class="list-unstyled">
		          <li><a href="/private/members/${h_membersId}"><spring:message code="menu.3.con1" /></a></li>
		          <li><a href="/private/members/${h_membersId}/book-history"><spring:message code="menu.3.con2" /></a></li>
		          <li><a href="/private/members/${h_membersId}/book-like"><spring:message code="menu.3.con3" /></a></li>
		          <li><a href="/private/members/${h_membersId}/book-req"><spring:message code="menu.3.con4" /></a></li>
		        </ul>
		      </div>
		    </div>
		  </div>
		</div>
     <div class="d-flex">
        <button class="btn btn-light border-white text-white menu_a_toggle" id="menu_a_toggle">∨</button>
     </div>
    </div>
  </div>
</nav>

<!-- submenu (절대 위치로 메뉴 아래 펼쳐지도록 수정) -->


<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>

<script type="text/javascript">





</script>