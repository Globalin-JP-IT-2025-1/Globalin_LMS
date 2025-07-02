<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="book" value="${book}" />

<!-- 도서 수정 폼 -->
<div class="w-100">
	<div class="card shadow-sm w-60 pt-5 my-3">
		<div class="container d-flex flex-column justify-content-center align-items-center editForm">
			<div class="mb-3 col-6 d-flex gap-3">
		        <div class="col-3 d-flex justify-content-start text-secondary">분류(KDC)</div>
		        <div class="input-group d-flex align-items-center">
		            <select class="form-select" multiple aria-label="KDC 분류 선택">
						<option disabled selected>KDC 분류 선택</option>
						<option value="000">총류</option>
						<option value="100">철학</option>
						<option value="200">종교</option>
						<option value="300">사회과학</option>
						<option value="400">자연과학</option>
						<option value="500">기술과학</option>
						<option value="600">예술</option>
						<option value="700">언어</option>
						<option value="800">문학</option>
						<option value="900">역사</option>
					</select>
		        </div>
		    </div>
<form action="/admin/books/${book.booksId}" method="post">
	<ul class="editBookForm">
	    <li> : <input type="text" id="category" value="${book.category}" maxlength="50"></li>
	    <li>제목 : <input type="text" id="title" value="${book.title}" maxlength="200"></li>
	    <li>저자 : <input type="text" id="author" value="${book.author}" maxlength="100"></li>
	    <li>출판사 : <input type="text" id="publisher" value="${book.publisher}" maxlength="100"></li>
	    <li>
	        ISBN : <input type="text" id="isbn" value="${book.isbn}" maxlength="50">
	        <button type="button" onclick="openIsbnPopup()">ISBN으로 도서 가져오기</button>
	    </li>
	    <li>책 이미지 : <input type="text" id="imageLink" value="${book.imageLink}" maxlength="300"></li>
	</ul>
	
	<input type="button" value="수정취소" onclick="cancelEdit()">
	<input type="submit" value="수정하기">
</form>

<script type="text/javascript">
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