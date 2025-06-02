<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/main.css">
	
<div class="main">
	<div class="m_title">
		<div class="m_submenu_title">
			<div class="m_submenu_title_tx">회원 정보</div>
		</div>
		<div class="m_main_title">
			<div class="m_pageTitle">${pageTitle}</div>
			<div class="m_pageRoute"><i class="bi bi-house-fill"></i> > 회원 정보 > ${pageTitle}</div>
		</div>
	</div>
	
	<div class="m_content">
		<div class="m_submenu_content">
			<div class="m_submenu_content_tx">
				<div class="m_submenu_item">로그인</div>
				<div class="m_submenu_item">가입 여부 확인</div>
				<div class="m_submenu_item">비밀번호 재발급</div>
				<div class="m_submenu_item">회원가입</div>
			</div>
		</div>

		<div class="m_main_content"><jsp:include page="${pagePath}" /></div>
	</div>
</div>