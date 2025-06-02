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