<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/main.css">
	
<div class="main">
	<div class="m_title">
		<div class="m_submenu_title">
			<div class="m_submenu_title_tx">${pageGroupTitle}</div>
		</div>
		<div class="m_main_title">
			<div class="m_pageTitle">${currentPageTitle}</div>
			<div class="m_pageRoute">
				<a href="/"><i class="bi bi-house-fill"></i></a> > 
				${pageGroupTitle} > 
				${currentPageTitle}
			</div>
		</div>
	</div>
	
	<div class="m_content">
		<div class="m_submenu_content">
			<div class="m_submenu_content_tx">
				<div class="m_submenu_item" id="mSubmenu1"><a href="${pageSubTitle1Uri}">${pageSubTitle1}</a></div>
				<div class="m_submenu_item" id="mSubmenu2"><a href="${pageSubTitle2Uri}">${pageSubTitle2}</a></div>
				<div class="m_submenu_item" id="mSubmenu3"><a href="${pageSubTitle3Uri}">${pageSubTitle3}</a></div>
				<c:if test="${not empty pageSubTitle4}">
				    <div class="m_submenu_item" id="mSubmenu4">
				        <a href="${pageSubTitle4Uri}">${pageSubTitle4}</a>
				    </div>
				</c:if>
			</div>
		</div>

		<div class="m_main_content"><jsp:include page="${pagePath}" /></div>
	</div>
</div>