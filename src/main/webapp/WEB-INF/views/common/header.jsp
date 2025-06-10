<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/header.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
#logoutBtn {
	all: unset;
}

#logoutBtn:hover {
    text-decoration: underline;
    cursor: pointer;
}

</style>

<c:set var="h_membersId" value="${sessionScope.currentMember.membersId}" /> 
<c:set var="h_username" value="${sessionScope.currentMember.username}" /> 
<c:set var="h_name" value="${sessionScope.currentMember.name}" />

<div class="header">
	<div class="h_1_bg">
		<div class="h_1">
			<div class="h1_1">
				<table>
					<tr>
						<td>🌐</td>
						<td class="current_lang"><a href="#" class="lang-btn" id="kr">한글</a></td>
						<td class=""><a href="#" class="lang-btn" id="jp">日本語</a></td>
						<td class=""><a href="#" class="lang-btn" id="en">English</a></td>
					</tr>
				</table>
			</div>
			<div class="h1_2">
				<div class="logo">
					<a href="/"> <img
						src="${pageContext.request.contextPath}/resources/images/title.png"
						alt="globalin-library">
					</a>
				</div>
			</div>
			<div class="h1_3">
				<div class="h_mini_menu">
					<table>
						<tr>
							<td><a href="/"><spring:message code="menu.0.title" /></a></td>
							<td>|</td>
							<c:choose>
								<c:when test="${empty h_membersId}">
									<td>
										<a href="/public/auth/login"><spring:message code="menu.6.con1" /></a>
									</td>
									<td>|</td>
									<td>
										<a href="/public/members/register"><spring:message code="menu.6.con4" /></a>
									</td>
									<td>|</td>
								</c:when>
								<c:otherwise>
									<td>
										<form action="/private/auth/logout/${h_membersId}" method="post">
											<c:set var="logout">
												<spring:message code="h.minimenu.logout" />
											</c:set>
											<input type="submit" value="${logout}" id="logoutBtn">
										</form>
									</td>
									<td>|</td>
								</c:otherwise>
							</c:choose>
							<td><a href="/etc/71"><spring:message code="menu.7.con1" /></a></td>
						</tr>
					</table>
				</div>
				
				<c:if test="${not empty h_membersId}">
					<div class="h_member_info">
						<a href="/private/members/${h_membersId}" id="mypage">
							<c:out value="${h_name}" />(<c:out value="${h_username}" />)
						</a> <spring:message code="h.welcome.message" />
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<div class="h_2_bg">
		<div class="h_2">
			<div class="h2_1">
				<div class="menu_each">
					<button class="menu_e_toggle" id="menu_1_toggle"><spring:message code="menu.1.title" /></button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_2_toggle"><spring:message code="menu.2.title" /></button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_3_toggle"><spring:message code="menu.4.title" /></button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_4_toggle"><spring:message code="menu.5.title" /></button>
					<div class="menu_e_blank">|</div>
					<button class="menu_e_toggle" id="menu_5_toggle"><spring:message code="menu.3.title" /></button>
					<div class="menu_e_blank">|</div>
				</div>
				<div class="menu_all">
					<button class="menu_a_toggle" id="menu_a_toggle">∨</button>
				</div>
			</div>

			<!-- display: none / block -->
			<div class="hidden" id="h_submenu">
				<!-- display: flex -->
				<div class="h2_2">
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">
								<a href="/public/books/total"><spring:message code="menu.1.con1" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/books/class"><spring:message code="menu.1.con2" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/books/loan"><spring:message code="menu.1.con3" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/books/like"><spring:message code="menu.1.con4" /></a>
							</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">
								<a href="/public/articles/notice"><spring:message code="menu.2.con1" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/articles/fnq"><spring:message code="menu.2.con2" /></a>
									</li>
							<li class="h_submenu_item">
								<a href="/public/articles/qna"><spring:message code="menu.2.con3" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/private/articles/req"><spring:message code="menu.2.con4" /></a>
							</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">
								<a href="/public/etc/41"><spring:message code="menu.4.con1" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/etc/42"><spring:message code="menu.4.con2" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/etc/43"><spring:message code="menu.4.con3" /></a>
							</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">
								<a href="/public/etc/51"><spring:message code="menu.5.con1" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/etc/52"><spring:message code="menu.5.con2" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/public/etc/53"><spring:message code="menu.5.con3" /></a>
							</li>
						</ul>
					</div>
					<div class="h_submenu_blank"></div>
					<div class="h_submenu">
						<ul>
							<li class="h_submenu_item">
								<a href="/private/members/${h_membersId}"><spring:message code="menu.3.con1" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/private/members/${h_membersId}/book-history"><spring:message code="menu.3.con2" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/private/members/${h_membersId}/book-like"><spring:message code="menu.3.con3" /></a>
							</li>
							<li class="h_submenu_item">
								<a href="/private/members/${h_membersId}/book-req"><spring:message code="menu.3.con4" /></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/resources/static/js/header.js"></script>

<script type="text/javascript">





</script>