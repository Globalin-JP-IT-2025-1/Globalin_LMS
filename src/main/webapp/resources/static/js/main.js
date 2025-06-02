// 서브메뉴 현재 메뉴 표시
document.addEventListener("DOMContentLoaded", function () {
  const items = document.querySelectorAll(".m_submenu_item");

  items.forEach(item => {
    item.addEventListener("click", function () {
      items.forEach(i => i.classList.remove("selected"));
      this.classList.add("selected");
    });
  });
});



