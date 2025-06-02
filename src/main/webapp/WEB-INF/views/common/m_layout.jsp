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
				<div class="m_submenu_item selected" id="mSubmenu1"><a href="#">로그인</a></div>
				<div class="m_submenu_item" id="mSubmenu2"><a href="#">가입 여부 확인</a></div>
				<div class="m_submenu_item" id="mSubmenu3"><a href="#">비밀번호 재발급</a></div>
				<div class="m_submenu_item" id="mSubmenu4"><a href="#">회원가입</a></div>
			</div>
		</div>

		<div class="m_main_content"><jsp:include page="${pagePath}" /></div>
	</div>
</div>