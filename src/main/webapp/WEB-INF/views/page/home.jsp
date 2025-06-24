<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.membersId" var="h_membersId" />
	<sec:authentication property="principal.username" var="h_username" />
	<sec:authentication property="principal.fullname" var="h_fullname" />
	<sec:authentication property="principal.status" var="h_status" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/home.css">

<div class="home">
	<div class="home_1_bg">
		<div class="home_1">
			<div class="home1_item1">
				<label id="searchType"><spring:message code="main.h1.1" /></label>
			</div>
			<div class="home1_item2">
				<input type="text" id="searchInput" placeholder="<spring:message code="main.h1.2" />" maxlength="20">
				<button id="searchBtn"><spring:message code="main.h1.3" /></button>
			</div>
		</div>
	</div>

	<div class="home_2_bg">
		<div class="home_2">
	        <c:choose>	
	        	<c:when test="${empty h_membersId}">					
					<div class="home_2_1">
						<div class="h2_1_top"><spring:message code="main.h2.1" /></div>
						<form action="/public/auth/login" method="post">
							<div class="h2_1_div1" id="loginForm">
								<div class="w-100"><input type="text" name="username" id="username" placeholder="<spring:message code="main.h2.2" />" maxlength="10"/></div>
								<div class="w-100"><input type="text" name="password" id="password" placeholder="<spring:message code="main.h2.3" />" maxlength="20"/></div>
								<div class="w-100"><input type="checkbox" id="acceptAutoLogin"><spring:message code="main.h2.4" /></div>	
								<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden=""/>
							</div>
							<div class="h2_1_div2 my-3">
								<input type="submit" class="loginbtn" value="<spring:message code="main.h2.14" />"/>
							</div>
						</form>
						
						<div class="h2_1_div3">
							<a href="/public/members/register" 
								class="m_submenu_active_target" 
				            	data-submenu="mSubmenu4"><spring:message code="main.h2.15" /></a>&nbsp;|
							<a href="/public/members/check" 
								class="m_submenu_active_target" 
				            	data-submenu="mSubmenu2"><spring:message code="main.h2.16" /></a>&nbsp;|
							<a href="/public/members/repass" 
								class="m_submenu_active_target" 
				            	data-submenu="mSubmenu3"><spring:message code="main.h2.17" /></a>
						</div>
					</div>
				</c:when>
	          	<c:otherwise>
		          	<div class="home_2_1">
						<div class="h2_1_div4">
				          <a href="/private/members/${h_membersId}" id="mypage" class="fw-bold text-decoration-none">
				            <c:out value="${h_fullname}" />(<c:out value="${h_username}" />)</a>
				          <spring:message code="h.welcome.message1" />
				        </div>
						<div class="h2_1_div5"> <!-- 부힉.... 푸힛... 헤헤...  -->
							<form action="/private/auth/logout" method="post" class="d-inline">
				            	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
								<input type="submit" value="<spring:message code='h.minimenu.logout' />" class="logoutbtn">
				            </form>
						</div>
						<hr class="border border-1 opacity-50">
						<div class="h2_1_div6">
							<button onclick="location.href='/private/members/${h_membersId}'"><spring:message code='menu.3.con1' /></button>
							<button onclick="location.href='/private/members/${h_membersId}/edit'">정보 수정</button>
						</div>
						<div class="h2_1_div7">
							<a href="/private/members/${h_membersId}/book-history"><i class="bi bi-bookmarks"></i><spring:message code='menu.3.con2' /></a>&nbsp;|
							<a href="/private/members/${h_membersId}/book-req"><i class="bi bi-pencil-square"></i><spring:message code='menu.3.con4' /></a>
						</div>
						<div class="h2_1_div8 bg-warning-subtle" onclick="location.href='/private/members/${h_membersId}/book-history'"><i class="bi bi-megaphone"></i>&nbsp;도서 연체 3일(총 2건)</div>
					</div>
				</c:otherwise>
	        </c:choose>
			
			<div class="home_2_2">
			  <div class="h2_2_top">
			    <div class="h2_2_left">
			      <a href="#" class="active"><spring:message code="main.h2.5" /></a> |
			      <a href="#"><spring:message code="main.h2.6" /></a> |
			      <a href="#"><spring:message code="main.h2.7" /></a>
			    </div>
			    <div class="h2_2_right">
			      <a href="#"><i class="bi bi-plus-circle"></i></a>
			    </div>
			  </div>
			
			  <div class="book_list">
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book1.jpg" alt="책1" class="book_img">
			      <div class="book_title">책제목1<br><span>저자1</span></div>
			    </div>
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book2.jpg" alt="책2" class="book_img">
			      <div class="book_title">책제목2<br><span>저자2</span></div>
			    </div>
			    <div class="book_card">
			      <img src="${pageContext.request.contextPath}/resources/static/images/book3.jpg" alt="책3" class="book_img">
			      <div class="book_title">책제목3<br><span>저자3</span></div>
			    </div>
			  </div>
			</div>

			<div class="home_2_3">
				<div class="h2_3_div1">
					<div class="h2_3_div1_left"><spring:message code="main.h2.8" /></div>
					<div class="h2_3_div1_right"><a href="#"><i class="bi bi-plus-circle"></i></a></div>
				</div>
			</div>
		</div>
	</div>
	<div class="home_3_bg">
	  <div class="home_3">
	    <div class="home_3_item" onclick="location.href='/public/etc/51'">
	    	<i class="bi bi-info-circle"></i><spring:message code="main.h2.9" />
    	</div>
	    <div class="home_3_item" onclick="location.href='/public/etc/53'">
	    	<i class="bi bi-book"></i><spring:message code="main.h2.10" />
    	</div>
	    <div class="home_3_item" onclick="location.href='/private/articles/req'">
	    	<i class="bi bi-pencil"></i> <spring:message code="main.h2.11" />
    	</div>
	    <div class="home_3_item" onclick="location.href='/public/books/loan'">
	    	<i class="bi bi-graph-up-arrow"></i><spring:message code="main.h2.12" />
    	</div>
	    <div class="home_3_item" onclick="location.href='/private/members/${h_membersId}/book-like'">
	    	<i class="bi bi-bookmark-heart"></i><spring:message code="main.h2.13" />
    	</div>
	  </div>
	</div>
	
	<div class="home_4_bg">
		<div class="home_4">
			<div class="home_4_left">
				<div class="lib_title"><p><i class="bi bi-bank"></i>&nbsp;<spring:message code="main.h3.1" /></p></div>
				<img class="lib_img" src="${pageContext.request.contextPath}/resources/images/library.png"/>
			</div>
			<div class="home_4_right">
				<p class="lib_welcome"><spring:message code="main.h3.2" /></p>
				<p><spring:message code="main.h3.3" /><br>
				<spring:message code="main.h3.4" /><br>
				<spring:message code="main.h3.5" /><br>
				<spring:message code="main.h3.6" />
				</p>
				<table class="lib_table">
					<tr>
						<th><spring:message code="main.h3.7" /></th>
						<td><spring:message code="main.h3.8" /><br><spring:message code="main.h3.9" /></td>
					</tr>
					<tr>
						<th><spring:message code="main.h3.10" /></th>
						<td><spring:message code="main.h3.11" /></td>
					</tr>
				</table>
				<div class="lib_btn_div">
					<button class="lib_btn" onclick="location.href='/public/etc/41'"><spring:message code="main.h3.12" /> &gt;</button>
					<button class="lib_btn" onclick="location.href='/public/etc/51'"><spring:message code="main.h3.13" /> &gt;</button>
				</div>
			</div>
		</div>
	</div>
	<div class="home_5_bg">
	  	<div class="home_5">
			<div class="banner_wrapper">
			  <div class="banner_track" id="bannerTrack">
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner1.jpg" alt="배너1"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner2.jpg" alt="배너2"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner3.jpg" alt="배너3"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner4.jpg" alt="배너4"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner5.jpg" alt="배너5"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner6.jpg" alt="배너6"></div>
			    <div class="banner_card"><img src="${pageContext.request.contextPath}/resources/static/images/banner7.jpg" alt="배너7"></div>
			  </div>
			</div>

		</div>
	</div>

</div>


<script
	src="${pageContext.request.contextPath}/resources/static/js/home.js"></script>

