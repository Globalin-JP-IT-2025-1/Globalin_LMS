/* 각 메뉴 열기,닫기 */
for (let i = 1; i <= 5; i++) {
    document.getElementById(`menu${i}_toggleBtn`).addEventListener("click", function() {
        document.getElementById("header_submenu").classList.toggle("hidden");
		
		if (document.getElementById("header_submenu").classList.contains("hidden")) {
			document.getElementById("menuAll_toggleBtn").textContent = "∨";
		} else {
			document.getElementById("menuAll_toggleBtn").textContent = "∧";
		}
    });
}


/* 전체 메뉴 열기,닫기 */
document.getElementById("menuAll_toggleBtn").addEventListener("click", function() {
    let submenu = document.getElementById("header_submenu");

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

document.getElementById("header_submenu").addEventListener("mouseleave", function() {
    let submenu = document.getElementById("header_submenu");

    if (!submenu.classList.contains("hidden")) {
		submenu.classList.toggle("hidden");
		document.getElementById("menuAll_toggleBtn").textContent = "∨";
	}
});