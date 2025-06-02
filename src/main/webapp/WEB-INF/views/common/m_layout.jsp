<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/main.css">

<div class="main">
	<div class="m_head">
		<div class="m_submenu_area"></div>
		<div class="m_h_main_area">
			<div class="m_h_pageTitle">${pageTitle}</div>
			<div class="m_h_pageRoute">홈 > 회원 정보 > ${pageTitle}</div>
		</div>
	</div>
	<div class="m_body">
		<div class="m_submenu_area"></div>
		<div class="m_main_area">
			<jsp:include page="${pagePath}" />
		</div>
	</div>
</div>