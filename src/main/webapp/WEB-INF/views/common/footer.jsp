<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/footer.css">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

<div class="footer">
	<div class="f_1">
		<div class="f1_1">
			<div class="f_title"><a href="/"><spring:message code="main.h4.1" /></a></div>
			<div class="f_title_en">Globalin Library</div>
		</div>

		<div class="f1_2">
			<div><spring:message code="main.h4.2" /></div>
			<div>TEL 02-0000-0000 | FAX 02-0000-0000</div>
			<div>EMAIL contact@globalin-library.com</div>
		</div>

		<div class="f1_3">
			<a href="/public/etc/73"
				data-menu-id="mSubmenu3" 
				onclick="handleNavigation(event, this)"><spring:message code="main.h4.3" /></a>
			&nbsp;
			<a href="/admin/books"
				data-menu-id="mSubmenu1" 
				onclick="handleNavigation(event, this)">Admin Page</a>
		</div>
	</div>
	<div class="f_2">
		Copyright &copy; 2025. GLOBALIN LIBRARY. All Rights Reserved.
	</div>
</div>

<script>
// 푸터 --> 메인 소메뉴 css (a태그)
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
</script>

