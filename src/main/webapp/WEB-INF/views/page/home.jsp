<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<c:set var="articleList" value="${articleList}" />
<c:set var="bookList" value="${bookList}" />

<c:set var="totalOverdueDay" value="${totalOverdueDay}" />
<c:set var="totalOverdueCount" value="${totalOverdueCount}" />


<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.membersId" var="h_membersId" />
	<sec:authentication property="principal.username" var="h_username" />
	<sec:authentication property="principal.fullname" var="h_fullname" />
	<sec:authentication property="principal.status" var="h_status" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/home.css">

<!-- <style>
* {
	border: 1px solid red;
}
</style> -->

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
								<div class="w-100">
									<input class="form-check-input" type="checkbox" name="remember-me" id="autoLoginBox" checked>
                   					<label class="form-check-label" for="autoLoginBox">
                   						<spring:message code="main.h2.4" />
                   					</label>
								</div>	
								<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden=""/>
							</div>
							<div class="h2_1_div2 my-3">
								<input type="submit" class="loginbtn" value="<spring:message code="main.h2.14" />"/>
							</div>
						</form>
						
						<div class="h2_1_div3">
							<a href="/public/members/register"
								data-menu-id="mSubmenu4" 
							    onclick="handleNavigation(event, this)"><spring:message code="main.h2.15" /></a>&nbsp;|
							<a href="/public/members/check"
								data-menu-id="mSubmenu2" 
							    onclick="handleNavigation(event, this)"><spring:message code="main.h2.16" /></a>&nbsp;|
							<a href="/public/members/repass"
								data-menu-id="mSubmenu3" 
							    onclick="handleNavigation(event, this)"><spring:message code="main.h2.17" /></a>
						</div>
					</div>
				</c:when>
	          	<c:otherwise>
		          	<div class="home_2_1">
						<div class="h2_1_div4">
				          <a href="/private/members/${h_membersId}" 
					          id="mypage" 
					          class="fw-bold text-decoration-none"
					          data-menu-id="mSubmenu1" 
							  onclick="handleNavigation(event, this)">
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
							<button data-url="/private/members/${h_membersId}"
								data-menu-id="mSubmenu1" 
							    onclick="handleNavigationDiv(event, this)"><spring:message code='menu.3.con1' /></button>
							<button data-url="/private/members/${h_membersId}/edit"
								data-menu-id="mSubmenu1" 
							     onclick="handleNavigationDiv(event, this)"><spring:message code='menu.3.button1' /></button>
						</div>
						<div class="h2_1_div7">
							<a href="/private/members/${h_membersId}/book-history"
								data-menu-id="mSubmenu2" 
							    onclick="handleNavigation(event, this)"><i class="bi bi-bookmarks"></i><spring:message code='menu.3.con2' /></a>&nbsp;|
							<a href="/private/members/${h_membersId}/book-req"
								data-menu-id="mSubmenu4" 
							     onclick="handleNavigation(event, this)"><i class="bi bi-pencil-square"></i><spring:message code='menu.3.con4' /></a>
						</div>
						<c:if test="${totalOverdueDay ne 0 and totalOverdueCount ne 0}">
							<div class="h2_1_div8 bg-warning-subtle" 
								data-url="/private/members/${h_membersId}/book-history"
								data-menu-id="mSubmenu2" 
							    onclick="handleNavigationDiv(event, this)">
								<div class="d-flex justify-content-center align-items-center overdueInfo">
									<i class="bi bi-megaphone"></i>&nbsp;<spring:message code="main.h2.18" arguments="${totalOverdueDay}, ${totalOverdueCount}" />
								</div>
							</div>
						</c:if>
					</div>
				</c:otherwise>
	        </c:choose>
			
			<div class="home_2_2">
				<div class="h2_2_top">
					<div class="h2_2_left">
					    <a href="/"
					       class="<c:if test='${empty param.book || param.book eq "1"}'>active</c:if>">
					       <spring:message code="main.h2.5" />
					    </a> |
					    <a href="/?book=2"
					       class="<c:if test='${param.book eq "2"}'>active</c:if>">
					       <spring:message code="main.h2.6" />
					    </a> |
					    <a href="/?book=3"
					       class="<c:if test='${param.book eq "3"}'>active</c:if>">
					       <spring:message code="main.h2.7" />
					    </a>
					</div>
					
					<div class="h2_2_right">
					    <c:choose>
							<c:when test="${param.book eq '2'}">
					        	<a href="/public/books/like"
					        		data-menu-id="mSubmenu4" 
							     	onclick="handleNavigation(event, this)"><i class="bi bi-plus-circle"></i></a>
					      	</c:when>
					      	<c:otherwise>
					        	<a href="/public/books/total"
					        		data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)"><i class="bi bi-plus-circle"></i></a>
					      	</c:otherwise>
					    </c:choose>
					</div>
				</div>
		  		<div class="book_list">
				    <div class="book_card">
					    <img src="${bookList[0].imageLink}" alt="${bookList[0].title} 표지" class="book_img">
					    <div class="book_title">
							<div class="d-inline-block text-truncate book_title_1">
								<a href="/public/books/${bookList[0].booksId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${bookList[0].title}</a>
							</div>
							<div class="d-inline-block text-truncate book_title_2">${bookList[0].author}</div>
						</div>
				    </div>
				    <div class="book_card">
				     	<img src="${bookList[1].imageLink}" alt="${bookList[1].title} 표지" class="book_img">
					 	<div class="book_title">
							<div class="d-inline-block text-truncate book_title_1">
								<a href="/public/books/${bookList[1].booksId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${bookList[1].title}</a>
							</div>
							<div class="d-inline-block text-truncate book_title_2">${bookList[1].author}</div>
						</div>
				    </div>
				    <div class="book_card">
					    <img src="${bookList[2].imageLink}" alt="${bookList[2].title} 표지" class="book_img">
					    <div class="book_title">
							<div class="d-inline-block text-truncate book_title_1">
								<a href="/public/books/${bookList[2].booksId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${bookList[2].title}</a>
							</div>
							<div class="d-inline-block text-truncate book_title_2">${bookList[2].author}</div>
						</div>
				    </div>
			  	</div>
			</div>

			<div class="home_2_3">
				<div class="h2_3_div1">
					<div class="h2_3_div1_left"><spring:message code="main.h2.8" /></div>
					<div class="h2_3_div1_right"><a href="/public/articles/not"
													data-menu-id="mSubmenu1" 
							     					onclick="handleNavigation(event, this)"><i class="bi bi-plus-circle"></i></a></div>
				</div>
				<div class="h2_3_div2 border-bottom border-secondary">
					<div class="w-100 h2_3_div2_item border-top border-secondary">
						<div class="h2_3_div2_item_item1">
							<div class="d-inline-block text-truncate article_title">
								<a href="/public/articles/not/${articleList[0].articlesId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${articleList[0].title}</a>
							</div>
						</div>
						<div class="h2_3_div2_item_item2 text-secondary">
							<fmt:formatDate value="${articleList[0].updateDate}" pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="w-100 h2_3_div2_item border-top border-secondary">
						<div class="h2_3_div2_item_item1">
							<div class="d-inline-block text-truncate article_title">
								<a href="/public/articles/not/${articleList[1].articlesId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${articleList[1].title}</a>
							</div>
						</div>
						<div class="h2_3_div2_item_item2 text-secondary">
							<fmt:formatDate value="${articleList[1].updateDate}" pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="w-100 h2_3_div2_item border-top border-secondary">
						<div class="h2_3_div2_item_item1">
							<div class="d-inline-block text-truncate article_title">
								<a href="/public/articles/not/${articleList[2].articlesId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${articleList[2].title}</a>
							</div>
						</div>
						<div class="h2_3_div2_item_item2 text-secondary">
							<fmt:formatDate value="${articleList[2].updateDate}" pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="w-100 h2_3_div2_item border-top border-secondary">
						<div class="h2_3_div2_item_item1">
							<div class="d-inline-block text-truncate article_title">
								<a href="/public/articles/not/${articleList[3].articlesId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${articleList[3].title}</a>
							</div>
						</div>
						<div class="h2_3_div2_item_item2 text-secondary">
							<fmt:formatDate value="${articleList[3].updateDate}" pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="w-100 h2_3_div2_item border-top border-secondary">
						<div class="h2_3_div2_item_item1">
							<div class="d-inline-block text-truncate article_title">
								<a href="/public/articles/not/${articleList[4].articlesId}"
									data-menu-id="mSubmenu1" 
							     	onclick="handleNavigation(event, this)">${articleList[4].title}</a>
							</div>
						</div>
						<div class="h2_3_div2_item_item2 text-secondary">
							<fmt:formatDate value="${articleList[4].updateDate}" pattern="yyyy-MM-dd" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="home_3_bg">
	  	<div class="home_3">
		    <div class="home_3_item" 
		    	data-url="/public/etc/51"
				data-menu-id="mSubmenu1" 
		    	onclick="handleNavigationDiv(event, this)">
		    	<i class="bi bi-info-circle"></i><spring:message code="main.h2.9" />
	    	</div>
		    <div class="home_3_item" 
		    	data-url="/public/etc/53"
				data-menu-id="mSubmenu3" 
			    onclick="handleNavigationDiv(event, this)">
		    	<i class="bi bi-book"></i><spring:message code="main.h2.10" />
	    	</div>
		    <div class="home_3_item" 
		    	data-url="/private/articles/req"
		   		data-menu-id="mSubmenu4" 
				onclick="handleNavigationDiv(event, this)">
		    	<i class="bi bi-pencil"></i> <spring:message code="main.h2.11" />
	    	</div>
		    <div class="home_3_item" 
		    	data-url="/public/books/loan"
		    	data-menu-id="mSubmenu3" 
				onclick="handleNavigationDiv(event, this)">
		    	<i class="bi bi-graph-up-arrow"></i><spring:message code="main.h2.12" />
	    	</div>
		    <div class="home_3_item" 
		    	data-url="/private/members/${h_membersId}/book-like"
		    	data-menu-id="mSubmenu3" 
				onclick="handleNavigationDiv(event, this)">
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
					<button class="lib_btn" 
						data-url="/public/etc/41"
						data-menu-id="mSubmenu1" 
						onclick="handleNavigationDiv(event, this)"><spring:message code="main.h3.12" /> &gt;</button>
					<button class="lib_btn" 
						data-url="/public/etc/51"
						data-menu-id="mSubmenu1" 
						onclick="handleNavigationDiv(event, this)"><spring:message code="main.h3.13" /> &gt;</button>
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

<script>
// 홈 --> 메인 소메뉴 css (a태그)
function handleNavigation(event, element) {
    const menuId = element.getAttribute("data-menu-id");
    const url = element.getAttribute("href");

    if (menuId) {
        sessionStorage.setItem("activeMenuId", menuId);
    }

    // 기본 링크 이동 막고 수동으로 이동
    event.preventDefault();
    if (url) {
        window.location.href = url;
    }
}
//홈 --> 메인 소메뉴 css (div, button태그)
function handleNavigationDiv(event, element) {
    const menuId = element.getAttribute("data-menu-id");
    const url = element.getAttribute("data-url");

    if (menuId) {
        sessionStorage.setItem("activeMenuId", menuId);
    }

    if (url) {
        window.location.href = url;
    }
}
</script>