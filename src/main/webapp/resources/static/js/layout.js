/* 스크롤 맨 위로 올리기 */
window.addEventListener("scroll", function () {
    let scrollBtn = document.getElementById("scrollUpBtn");

    if (window.scrollY > 200) {
        scrollBtn.style.display = "block";
    } else {
        scrollBtn.style.display = "none";
    }
});

document.getElementById("scrollUpBtn").addEventListener("click", function () {
    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });
});

/* 스크롤 시 메인 서브메뉴 고정 */
if (window.location.pathname !== "/") {
    window.addEventListener("scroll", function () {
        let menu = document.querySelector(".m_submenu");

        if (window.scrollY > 50) {
            menu.classList.add("m_menu_fixed");
        } else {
            menu.classList.remove("m_menu_fixed");
        }

    });
} else {
    console.log("메인 페이지여서 실행 안함!!");
}