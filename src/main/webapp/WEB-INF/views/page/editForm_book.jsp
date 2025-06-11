<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="book" value="${book}" />

<!-- 도서 수정 폼 -->
<ul class="editBookForm">
    <li>
        도서ID : <input type="text" id="booksId" value="${book.booksId}" readonly>
        <span style="color:red; font-weight:bold;">변경 불가</span>
    </li>
    <li>분류(종류) : <input type="text" id="category" value="${book.category}" maxlength="50"></li>
    <li>제목 : <input type="text" id="title" value="${book.title}" maxlength="200"></li>
    <li>저자 : <input type="text" id="author" value="${book.author}" maxlength="100"></li>
    <li>출판사 : <input type="text" id="publisher" value="${book.publisher}" maxlength="100"></li>
    <li>
        ISBN : <input type="text" id="isbn" value="${book.isbn}" maxlength="50">
        <button type="button" onclick="openIsbnPopup()">ISBN으로 도서 가져오기</button>
    </li>
    <li>책 이미지 : <input type="text" id="imageLink" value="${book.imageLink}" maxlength="300"></li>
</ul>
<button onclick="cancelEdit()">수정취소</button>
<button onclick="updateBookInfo(${book.booksId})">수정하기</button>

<script>
function openIsbnPopup() {
    window.open('/page/searchBook.jsp', 'isbnSearch', 'width=500,height=250');
}
function cancelEdit() {
    const confirmCancel = confirm("정말 취소하시겠습니까?");
    if (confirmCancel) history.back();
}
function updateBookInfo(booksId) {
    const book = {
        booksId: booksId,
        category: document.getElementById("category").value,
        title: document.getElementById("title").value,
        author: document.getElementById("author").value,
        publisher: document.getElementById("publisher").value,
        isbn: document.getElementById("isbn").value,
        imageLink: document.getElementById("imageLink").value
    };
    Swal.fire({
        title: "도서 정보 수정",
        text: "도서 정보를 수정하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "수정",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/books/${booksId}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(book)
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("수정 완료", "도서 정보가 수정되었습니다.", "success")
                        .then(() => location.reload());
                } else {
                    Swal.fire("오류 발생", "도서 정보 수정 실패했습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
            });
        }
    });
}
</script>