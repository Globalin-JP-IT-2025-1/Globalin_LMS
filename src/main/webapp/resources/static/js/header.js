/* 메뉴 */
/* 각 메뉴 열기,닫기 */
for (let i = 1; i <= 5; i++) {
	document.getElementById(`menu_${i}_toggle`).addEventListener("click", function() {
		document.getElementById("h_submenu").classList.toggle("hidden");

		if (document.getElementById("h_submenu").classList.contains("hidden")) {
			document.getElementById("menu_a_toggle").textContent = "∨";
		} else {
			document.getElementById("menu_a_toggle").textContent = "∧";
		}
	});
}

/* 전체 메뉴 열기,닫기 */
document.getElementById("menu_a_toggle").addEventListener("click", function() {
	let submenu = document.getElementById("h_submenu");

	if (!submenu) return; // 메뉴가 존재하지 않으면 실행 중단

	let isHidden = submenu.classList.contains("hidden");

	if (isHidden) {
		submenu.classList.remove("hidden");
		this.textContent = "∧";
	} else {
		submenu.classList.add("hidden");
		this.textContent = "∨";
	}
});

document.getElementById("h_submenu").addEventListener("mouseleave", function() {
	let submenu = document.getElementById("h_submenu");

	if (!submenu.classList.contains("hidden")) {
		submenu.classList.toggle("hidden");
		document.getElementById("menu_a_toggle").textContent = "∨";
	}
});



/* 다국어 */
/* 브라우저 로딩 시 기본 언어 세션에 저장*/
/* 현재 브라우저 세션에 등록된 언어에 따라 css 현재 언어 설정 */
window.onload = function() {
	if (!sessionStorage.getItem("lang")) {
		sessionStorage.setItem("lang", "kr");
	}

	let currentLang = sessionStorage.getItem("lang");
	console.log(currentLang);

	let langSet = ["kr", "jp", "en"];

	langSet.forEach((lang) => {
		let langParent = document.getElementById(`${lang}`).parentElement;

		if (lang === currentLang) {
			langParent.classList.add("current_lang");
		} else {
			langParent.classList.remove("current_lang");
		}
	});
};

/* 언어 설정 클릭 시 세션 변경, css 변경 */
window.onload = function() {
	if (!sessionStorage.getItem("lang")) {
		sessionStorage.setItem("lang", "kr");
	}
	updateLanguage(sessionStorage.getItem("lang"));
};

function updateLanguage(lang) {
	sessionStorage.setItem("lang", lang);
	document.querySelectorAll(".lang-btn").forEach((btn) => {
		btn.parentElement.classList.toggle("current_lang", btn.id === lang);
	});
}

document.querySelectorAll(".lang-btn").forEach((btn) => {
	btn.addEventListener("click", () => updateLanguage(btn.id));
});

