<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
/* 카테고리 버튼 그리드 */
.category-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 16px 18px;
    max-width: 640px;
    margin: 0 auto 36px auto;
    padding: 0 12px;
}
.category-btn {
    background: #f7fbfd;
    border: 2px solid #176bb9;
    color: #176bb9;
    font-size: 1.09em;
    font-weight: 600;
    border-radius: 20px;
    padding: 13px 0 12px 0;
    text-align: center;
    cursor: pointer;
    outline: none;
    transition: all 0.15s;
    min-width: 90px;
    box-shadow: 0 2px 8px rgba(23,107,185,0.04);
}
.category-btn.selected,
.category-btn:hover {
    background: #176bb9;
    color: #fff;
    border-color: #176bb9;
    box-shadow: 0 2px 14px rgba(23,107,185,0.10);
}
@media (max-width: 900px) {
    .category-grid { grid-template-columns: repeat(3, 1fr);}
}
@media (max-width: 650px) {
    .category-grid { grid-template-columns: repeat(2, 1fr);}
}

/* 도서 테이블 */
.table-books {
    width: 100%;
    border-collapse: collapse;
    font-size: 1.03em;
    table-layout: fixed;
    margin-bottom: 0;
}
.table-books th, .table-books td {
    padding: 16px 14px;
    text-align: left;
    border-bottom: 1.7px solid #cbeaff;
}
.table-books th {
    background: #eaf6ff;
    color: #176bb9;
    font-weight: bold;
    font-size: 1.08em;
}
.table-books td {
    background: #f6fbfd;
    font-size: 1em;
}
.table-books td.book-cover {
    width: 90px;
    min-width: 90px;
    text-align: center;
    background: #fff;
}
.table-books td.book-title {
    width: 340px;
    min-width: 260px;
    max-width: 900px;
    font-weight: 500;
    background: #fff;
    white-space: normal;
    word-break: break-all;
}
.table-books td.book-status {
    width: 110px;
    min-width: 90px;
    text-align: center;
    font-weight: bold;
    color: #1c7ccd;
    background: #eaf6ff;
    letter-spacing: 1.5px;
    font-size: 1.06em;
}
.table-books tr:hover td {
    background: #e2f1fa;
}
/* 전체 건수 안내 */
.total-count-bar {
    margin-bottom: 8px;
    font-size: 1.13em;
    font-weight: 500;
    color: #217bb9;
    text-align: left;
}
</style>

<div class="category-grid">
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="000" class="category-btn${classNo=='000'?' selected':''}">총류</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="100" class="category-btn${classNo=='100'?' selected':''}">철학</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="200" class="category-btn${classNo=='200'?' selected':''}">종교</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="300" class="category-btn${classNo=='300'?' selected':''}">사회과학</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="400" class="category-btn${classNo=='400'?' selected':''}">자연과학</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="500" class="category-btn${classNo=='500'?' selected':''}">기술과학</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="600" class="category-btn${classNo=='600'?' selected':''}">예술</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="700" class="category-btn${classNo=='700'?' selected':''}">언어</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="800" class="category-btn${classNo=='800'?' selected':''}">문학</button>
    </form>
    <form action="/public/books/class" method="get" style="margin:0;">
        <button name="class_no" value="900" class="category-btn${classNo=='900'?' selected':''}">역사</button>
    </form>
</div>

<!-- ====== 전체 건수 안내 ====== -->
<div class="total-count-bar">
    전체 <b>${totalCount}</b> 건
</div>

<!-- ====== 도서 목록 테이블 ====== -->
<table class="table-books">
    <tr>
        <th style="width:60px;">NO</th>
        <th style="width:90px;">책표지</th>
        <th style="min-width:260px; max-width:900px;">책제목</th>
        <th>저자</th>
        <th>출판사</th>
        <th style="width:110px;">상태</th>
    </tr>
    <c:forEach var="book" items="${bookList}" varStatus="stat">
        <tr>
            <td style="text-align:center;">${stat.index + 1 + (currentPage-1)*10}</td>
            <td class="book-cover">
                <c:choose>
                    <c:when test="${not empty book.imageLink}">
                        <img src="${book.imageLink}" style="width:64px; height:auto; border:1px solid #dde9f2;">
                    </c:when>
                    <c:otherwise>
                        <img src="/resources/images/no-image.jpg" style="width:64px; height:auto; border:1px solid #eee;">
                    </c:otherwise>
                </c:choose>
            </td>
            <!-- ===== 책제목: booksId 0이 아니면 링크, 0이면 회색 ===== -->
            <td class="book-title">
                <c:choose>
                    <c:when test="${book.booksId != 0}">
                        <a href="/public/books/detail?booksId=${book.booksId}"
                           style="color:#217bb9; text-decoration:underline; cursor:pointer;">
                            ${book.title}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span style="color:#aaa; cursor:not-allowed;">${book.title}</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${book.author}</td>
            <td>${book.publisher}</td>
            <td class="book-status">
                <c:set var="curStatus" value="none" />
                <c:if test="${dbStatusMap[book.isbn] ne null}">
                    <c:set var="curStatus" value="${dbStatusMap[book.isbn]}" />
                </c:if>
                <c:choose>
                    <c:when test="${curStatus eq '0'}"><span style="color:#2cbb2c;">대여가능</span></c:when>
                    <c:when test="${curStatus eq '1'}"><span style="color:#fa6400;">대여중</span></c:when>
                    <c:otherwise><span style="color:#999;">대여불가</span></c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- ====== 페이징 ====== -->
<c:if test="${totalPage > 1}">
    <div style="width:100%; display:flex; justify-content:center; margin:32px 0 8px 0;">
        <div>
            <c:set var="startPage" value="${(currentPage-1)/5*5 + 1}" />
            <c:set var="endPage" value="${startPage+4 < totalPage ? startPage+4 : totalPage}" />
            <c:if test="${currentPage > 1}">
                <a href="?class_no=${classNo}&amp;pageNo=${currentPage - 1}" style="margin:0 6px;">&lt;</a>
            </c:if>
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <a href="?class_no=${classNo}&amp;pageNo=${i}"
                   style="margin:0 3px; ${i == currentPage ? 'font-weight:bold;color:#176bb9;font-size:1.15em;' : 'color:#3b4a67;'}">
                    ${i}
                </a>
            </c:forEach>
            <c:if test="${currentPage < totalPage}">
                <a href="?class_no=${classNo}&amp;pageNo=${currentPage + 1}" style="margin:0 6px;">&gt;</a>
            </c:if>
        </div>
    </div>
</c:if>

<!-- ====== 검색결과 없을 때 안내 ====== -->
<c:if test="${empty bookList}">
    <div style="text-align:center; color:#999; margin-top:30px; font-size:1.15em;">검색 결과가 없습니다.</div>
</c:if>
