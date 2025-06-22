/* 메인 소메뉴 CSS 적용을 위한 설정 */
// 헤더 미니메뉴, 서브메뉴, 푸터 미니메뉴: 클릭 시 메뉴코드를 세션에 저장만 함.
document.querySelectorAll(".m_submenu_active_target").forEach(item => {
	item.addEventListener("click", () => {
		const code = item.dataset.submenu;
		if (code) sessionStorage.setItem("activeSubmenu", code);
	});
});
