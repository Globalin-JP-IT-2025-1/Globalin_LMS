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
					<div class="m_submenu_item" id="mSubmenu1" onclick="setActiveMenu(this)" data-url="${pageSubTitle1Uri}">${pageSubTitle1}</div>
					<div class="m_submenu_item" id="mSubmenu2" onclick="setActiveMenu(this)" data-url="${pageSubTitle2Uri}">${pageSubTitle2}</div>
					<div class="m_submenu_item" id="mSubmenu3" onclick="setActiveMenu(this)" data-url="${pageSubTitle3Uri}">${pageSubTitle3}</div>
					<c:if test="${not empty pageSubTitle4}">
					    <div class="m_submenu_item" id="mSubmenu4" onclick="setActiveMenu(this)" data-url="${pageSubTitle4Uri}">
					        ${pageSubTitle4}
					    </div>
					</c:if>
				</div>
			</div>
	
			<div class="m_main_content"><jsp:include page="${pagePath}" /></div>
		</div>
	</div>
</div>


<script>
function setActiveMenu(element) {
	const id = element.id;
	const url = element.getAttribute("data-url");

	// 브라우저 세션에 클릭한 메뉴 ID 저장
	sessionStorage.setItem("activeMenuId", id);

	// 해당 URL로 이동
	window.location.href = url;
}

// 페이지 로드 시 저장된 메뉴 ID 또는 URI 조건으로 active 클래스 적용
window.addEventListener("DOMContentLoaded", function () {
    const path = window.location.pathname;
    const search = window.location.search;

    // 1. URI 조건 기반 강제 적용
    let activeId = null;

    if (path === "/public/auth/login" && search.includes("status=0")) {
        activeId = "mSubmenu1";
    } else if (path.endsWith("/book-history")) {
        activeId = "mSubmenu2";
    } else if (path.endsWith("/book-like")) {
        activeId = "mSubmenu3";
    } else if (path.endsWith("/book-req")) {
        activeId = "mSubmenu4";
    }

    // 2. 세션스토리지 기반 적용 (URI 조건이 없을 때만)
    if (!activeId) {
        activeId = sessionStorage.getItem("activeMenuId");
    }

    // 최종 active 클래스 적용
    if (activeId) {
        const activeElement = document.getElementById(activeId);
        if (activeElement) {
            activeElement.classList.add("active_menu");
        }
    }
});

</script>


