<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/main.css">

<div class="main">
	<div class="m_title_bg">
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
	</div>

	<div class="m_content_bg">
		<div class="m_content">
			<div class="m_submenu_content">
				<div class="m_submenu_content_tx">
					<div class="m_submenu_item" id="mSubmenu1" onclick="location.href='${pageSubTitle1Uri}'">${pageSubTitle1}</div>
					<div class="m_submenu_item" id="mSubmenu2" onclick="location.href='${pageSubTitle2Uri}'">${pageSubTitle2}</div>
					<div class="m_submenu_item" id="mSubmenu3" onclick="location.href='${pageSubTitle3Uri}'">${pageSubTitle3}</div>
					<c:if test="${not empty pageSubTitle4}">
					    <div class="m_submenu_item" id="mSubmenu4" onclick="location.href='${pageSubTitle4Uri}'">
					        ${pageSubTitle4}
					    </div>
					</c:if>
				</div>
			</div>
	
			<div class="m_main_content"><jsp:include page="${pagePath}" /></div>
		</div>
	</div>
</div>