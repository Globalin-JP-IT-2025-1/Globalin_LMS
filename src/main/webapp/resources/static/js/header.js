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
document.addEventListener("DOMContentLoaded", function () {
	// 기본 언어 설정
	if (!sessionStorage.getItem("lang")) {
		const defaultLang = "ko";
	  	sessionStorage.setItem("lang", defaultLang);
	  	location.href = "/lang/" + defaultLang;
	}

	const langSet = ["ko", "ja", "en"];
	const currentLang = sessionStorage.getItem("lang");

	// 초기 언어에 맞는 CSS 설정
	langSet.forEach((lang) => {
		let btn = document.getElementById(lang);
	    let parent = btn.parentElement;
	    if (lang === currentLang) {
			parent.classList.add("current_lang");
			btn.classList.add("btn-primary");
			btn.classList.remove("btn-outline-secondary");
	    } else {
			parent.classList.remove("current_lang");
			btn.classList.add("btn-outline-secondary");
			btn.classList.remove("btn-primary");
	    }
	});
	
	// 언어 버튼 클릭 이벤트
	document.querySelectorAll(".lang-btn").forEach((btn) => {
		btn.addEventListener("click", function () {
			const selectedLang = this.id;
			sessionStorage.setItem("lang", selectedLang);
	
	      	langSet.forEach((lang) => {
		        let langBtn = document.getElementById(lang);
		        let parent = langBtn.parentElement;
		        if (lang === selectedLang) {
					parent.classList.add("current_lang");
					langBtn.classList.add("btn-primary");
					langBtn.classList.remove("btn-outline-secondary");
		        } else {
		        	parent.classList.remove("current_lang");
		        	langBtn.classList.add("btn-outline-secondary");
		         	langBtn.classList.remove("btn-primary");
		        }
      		});
			// 서버에 저장 요청
			location.href = "/lang/" + selectedLang;
    	});
  	});
});


/* 스크롤 시 헤더 메뉴 고정 */
window.addEventListener("scroll", function () {
    let menu = document.querySelector(".navbar-main");
    let menuTop = menu.offsetTop;

	  if (window.scrollY > 100) {
	    menu.classList.add("menu_fixed");
	} else {
	    menu.classList.remove("menu_fixed");
	}
});

document.querySelectorAll('.menu_e_toggle, .menu_a_toggle').forEach(function(element) {
    element.addEventListener('keydown', function(event) {
        if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            element.click();
        }
    });
});