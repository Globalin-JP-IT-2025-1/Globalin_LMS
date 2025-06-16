<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 내 서재 > 관심 도서 목록 -->

<ul id="list">
  <li draggable="true">항목 1</li>
  <li draggable="true">항목 2</li>
  <li draggable="true">항목 3</li>
</ul>

<div id="trash">🗑 삭제 영역</div>

<script>
  const items = document.querySelectorAll("#list li");
  const trash = document.getElementById("trash");

  items.forEach(item => {
    item.addEventListener("dragstart", e => {
      e.dataTransfer.setData("text", e.target.innerText);
      e.target.classList.add("dragging");
    });
  });

  trash.addEventListener("dragover", e => {
    e.preventDefault();
  });

  trash.addEventListener("drop", e => {
    e.preventDefault();
    const draggedText = e.dataTransfer.getData("text");
    document.querySelectorAll("#list li").forEach(li => {
      if (li.innerText === draggedText) {
        li.remove();
      }
    });
  });
</script>
