// 서브메뉴 현재 메뉴 표시
// 헤더 미니메뉴, 서브메뉴, 푸터 미니메뉴: 클릭 시 메뉴코드를 세션에 저장만 함.
document.querySelectorAll(".m_submenu_active_target").forEach(item => {
	item.addEventListener("click", () => {
		const code = item.dataset.submenu;
		if (code) sessionStorage.setItem("activeSubmenu", code);
	});
});

// 메인 서브메뉴: 클릭 시 메뉴코드를 세션에 저장하고 css가 변경됨.
document.addEventListener("DOMContentLoaded", () => {
	const submenuItems = document.querySelectorAll(".main .m_submenu_item");

	// 저장된 ID가 있으면 해당 요소에 active_menu 클래스 적용
	const savedId = sessionStorage.getItem("activeSubmenu");
	if (savedId) {
		submenuItems.forEach(item => {
			item.classList.toggle("active_menu", item.id === savedId);
		});
	}

	// 클릭 시: 세션 저장 + 스타일 적용 + 페이지 이동
	submenuItems.forEach(item => {
		item.addEventListener("click", () => {
			const id = item.id;
			if (id) sessionStorage.setItem("activeSubmenu", id);

			submenuItems.forEach(i => i.classList.remove("active_menu"));
			item.classList.add("active_menu");

			const uri = item.getAttribute("data-uri");
			if (uri) location.href = uri;
		});
	});
});


