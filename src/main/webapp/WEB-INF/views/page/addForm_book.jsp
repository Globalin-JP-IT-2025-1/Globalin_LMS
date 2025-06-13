<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 도서 추가 폼 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="addBookForm">
    <li>분류(종류) : <input type="text" id="category" maxlength="50"></li>
    <li>제목 : <input type="text" id="title" maxlength="200"></li>
    <li>저자 : <input type="text" id="author" maxlength="100"></li>
    <li>출판사 : <input type="text" id="publisher" maxlength="100"></li>
    <li>
        ISBN : <input type="text" id="isbn" maxlength="50">
        <button type="button" onclick="openIsbnPopup()">ISBN으로 도서 가져오기</button>
    </li>
    <li>책 이미지 : <input type="text" id="imageLink" maxlength="300"></li>
</ul>
<button onclick="cancelAdd()">취소</button>
<button onclick="insertBook()">등록하기</button>

<script type="text/javascript">
function openIsbnPopup() {
    // /page/searchBook.jsp 팝업 띄우기 (ISBN 자동입력 구현은 여기서 fetch/연동 필요)
    window.open('/page/searchBook.jsp', 'isbnSearch', 'width=500,height=250');
}
function cancelAdd() {
    const confirmCancel = confirm("정말 취소하시겠습니까?");
    if (confirmCancel) history.back();
}
function insertBook() {
    const book = {
        category: document.getElementById("category").value,
        title: document.getElementById("title").value,
        author: document.getElementById("author").value,
        publisher: document.getElementById("publisher").value,
        isbn: document.getElementById("isbn").value,
        imageLink: document.getElementById("imageLink").value
    };
    Swal.fire({
        title: "도서 등록",
        text: "도서를 등록하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "등록",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/books`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(book)
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("등록 완료", "도서가 등록되었습니다.", "success")
                        .then(() => location.href = "/books");
                } else {
                    Swal.fire("오류 발생", "도서 등록에 실패했습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
            });
        }
    });
}
</script>
   