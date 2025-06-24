<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.membersId" var="h_membersId" />
	<sec:authentication property="principal.username" var="h_username" />
	<sec:authentication property="principal.fullname" var="h_fullname" />
	<sec:authentication property="principal.status" var="h_status" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="container-fluid border-bottom py-4 bg-white">
	<div class="container d-flex justify-content-between align-items-center">
		<div class="d-flex align-items-center">
			<div class="lang_icon"><i class="bi bi-globe fs-2 me-3"></i></div>
			<div class="btn-group btn-group-sm" role="group" aria-label="Language selector">
		        <button type="button" class="btn btn-outline-secondary lang-btn" id="ko">한글</button>
		        <button type="button" class="btn btn-outline-secondary lang-btn" id="ja">日本語</button>
		        <button type="button" class="btn btn-outline-secondary lang-btn" id="en">English</button>
			</div>
		</div>
	
	    <div class="text-center d-flex flex-column justify-content-center">
			<div class="h_title text-dark fw-bolder h1 m-0"><a href="/"><spring:message code="main.title" /></a></div>
			<div class="h_title_en h5 text-dark m-0">Globalin Library</div>
	    </div>

	    <div class="text-end">
			<div class="d-flex justify-content-end gap-2 align-items-center h_mini_menu">
		        <a href="/" class="fw-semibold"><spring:message code="menu.0.title" /></a>
		        <span>|</span>
		        <c:choose>
					<c:when test="${empty h_membersId}">
			            <a href="/public/auth/login?status=1" 
				            class="fw-semibold m_submenu_active_target" 
				            data-submenu="mSubmenu1"><spring:message code="menu.6.con1" /></a>
			            <span>|</span>
			            <a href="/public/members/register" 
				            class="fw-semibold m_submenu_active_target" 
				            data-submenu="mSubmenu4"><spring:message code="menu.6.con4" /></a>
			            <span>|</span>
		          	</c:when>
		          	<c:otherwise>
			            <form action="/private/auth/logout" method="post" class="d-inline">
			            	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
							<input type="submit" value="<spring:message code='h.minimenu.logout' />" id="logoutBtn" class="btn btn-link p-0 fw-semibold">
			            </form>
		            	<span>|</span>
		          	</c:otherwise>
		        </c:choose>
		        <a href="/public/etc/71" 
		        	class="fw-semibold m_submenu_active_target" 
				    data-submenu="mSubmenu1"><spring:message code="menu.7.con1" /></a>
		    </div>
		    <c:if test="${not empty h_membersId}">
		        <div class="mt-1 px-3 py-1 h_member_info">
					<a href="/private/members/${h_membersId}" id="mypage" class="fw-bold text-decoration-none">
					<c:out value="${h_fullname}" />(<c:out value="${h_username}" />)</a>
					<spring:message code="h.welcome.message2" />
					<span>|</span>
					<c:choose>
			          	<c:when test="${h_status eq 0}">
			          		<span>준회원</span>
			          	</c:when>
			          	<c:when test="${h_status eq 1}">
			          		<span>정회원</span>
			          	</c:when>
			          	<c:when test="${h_status eq 2}">
			          		<span class="text-danger">대출정지</span>
			          	</c:when>
			          	<c:when test="${h_status eq 9}">
			          		<span>관리자</span>
			          	</c:when>
			          	<c:otherwise>
			          		<span>게스트</span>
			          	</c:otherwise>
		          	</c:choose>
				</div>
			</c:if>
		</div>
	</div>
</div>

<!-- 메인 메뉴 바 -->
<nav class="navbar navbar-expand-lg navbar-main border-top border-bottom">
	<div class="container">
		<div class="collapse navbar-collapse show">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 d-flex align-items-center">
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
		    		<button class="btn btn-link nav-link fw-bold menu_e_toggle" id="menu_5_toggle" style="margin-left: 5px;"><spring:message code="menu.3.title" /></button>
		        </li>
		        <li class="nav-item">
	        		<button class="btn btn-light border-white text-white menu_a_toggle" id="menu_a_toggle">∨</button>
		        </li>
   			</ul>
			
			<!-- 서브 메뉴 -->
	      	<div class="position-absolute w-100 hidden shadow-sm" id="h_submenu">
				<div class="container py-4">
					<div class="row row-cols-1 row-cols-md-5 g-4">
						<div class="col">
			 				<ul class="list-unstyled">
			          			<li>
			          				<a href="/public/books/total" 
			          					class="m_submenu_active_target" 
			          					data-submenu="mSubmenu1"><spring:message code="menu.1.con1" /></a>
			          			</li>
					          	<li><a href="/public/books/class" 
					          			class="m_submenu_active_target" 
					          			data-submenu="mSubmenu2"><spring:message code="menu.1.con2" /></a>
					          	</li>
					          	<li><a href="/public/books/loan" 
					          			class="m_submenu_active_target" 
					          			data-submenu="mSubmenu3"><spring:message code="menu.1.con3" /></a>
					          	</li>
					          	<li><a href="/public/books/like" 
					          			class="m_submenu_active_target" 
					          			data-submenu="mSubmenu4"><spring:message code="menu.1.con4" /></a>
					          	</li>
		        			</ul>
			      		</div>
			      		<div class="col">
					        <ul class="list-unstyled">
					        	<li><a href="/public/articles/not" 
					        			class="m_submenu_active_target" 
					        			data-submenu="mSubmenu1"><spring:message code="menu.2.con1" /></a>
					        	</li>
					          	<li><a href="/public/articles/faq" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu2"><spring:message code="menu.2.con2" /></a>
						        </li>
					          	<li><a href="/public/articles/qna" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu3"><spring:message code="menu.2.con3" /></a>
						        </li>
					          	<li><a href="/private/articles/req" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu4"><spring:message code="menu.2.con4" /></a>
						        </li>
					        </ul>
			     		 </div>
			      		<div class="col">
					        <ul class="list-unstyled">
					          	<li><a href="/public/etc/41" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu1"><spring:message code="menu.4.con1" /></a>
					          	</li>
					          	<li><a href="/public/etc/42" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu2"><spring:message code="menu.4.con2" /></a>
					          	</li>
					          	<li><a href="/public/etc/43" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu3"><spring:message code="menu.4.con3" /></a>
					          	</li>
					        </ul>
			      		</div>
				      	<div class="col">
					        <ul class="list-unstyled">
					          	<li><a href="/public/etc/51" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu1"><spring:message code="menu.5.con1" /></a>
					          	</li>
					          	<li><a href="/public/etc/52" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu2"><spring:message code="menu.5.con2" /></a>
					          	</li>
					          	<li><a href="/public/etc/53" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu3"><spring:message code="menu.5.con3" /></a>
					          	</li>
					        </ul>
				      	</div>
				      	<div class="col">
					        <ul class="list-unstyled">
					          	<li><a href="/private/members/${h_membersId}" 
							          	class="m_submenu_active_target" 
							          	data-submenu="mSubmenu1"><spring:message code="menu.3.con1" /></a>
					          	</li>
					          	<li><a href="/private/members/${h_membersId}/book-history" 
					          			class="m_submenu_active_target" 
							          	data-submenu="mSubmenu2"><spring:message code="menu.3.con2" /></a>
							    </li>
					          	<li><a href="/private/members/${h_membersId}/book-like" 
					          			class="m_submenu_active_target" 
							          	data-submenu="mSubmenu3"><spring:message code="menu.3.con3" /></a>
							    </li>
					          	<li><a href="/private/members/${h_membersId}/book-req"  
					          			class="m_submenu_active_target" 
							          	data-submenu="mSubmenu4"><spring:message code="menu.3.con4" /></a>
							    </li>
					        </ul>
			      		</div>
		    		</div>
		 	 	</div>
			</div>
    	</div>
  	</div>
</nav>

<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>

