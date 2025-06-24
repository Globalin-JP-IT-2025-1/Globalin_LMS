<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.search-bar {
    width: 100%;
    display: flex;
    align-items: center;
    background: #eaf6ff;
    border-radius: 13px;
    padding: 22px 20px 22px 16px;
    margin-bottom: 20px;
    gap: 16px;
    box-sizing: border-box;
}
.search-bar select,
.search-bar input[type="text"] {
    height: 36px;
    font-size: 1.08em;
    border-radius: 7px;
    border: 1px solid #176bb944;
    padding: 0 15px;
    background: #fff;
}
.search-bar input[type="text"] {
    flex: 1 1 340px;
    min-width: 180px;
}
.search-bar button {
    background: #176bb9;
    color: #fff;
    border: none;
    border-radius: 7px;
    height: 36px;
    min-width: 72px;
    font-size: 1.08em;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.15s;
}
.search-bar button:hover {
    background: #1559a5;
}
.table-books {
    width: 100%;
    border-collapse: collapse;
    font-size: 1.03em;
    table-layout: fixed;
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
.button-request {
    margin-left: 8px;
    padding: 4px 13px;
    border-radius: 7px;
    background: #f5fbff;
    color: #217bb9;
    border: 1px solid #b8dbf6;
    font-size: 0.98em;
    cursor: pointer;
}
.button-request:hover {
    background: #eaf6ff;
}
</style>

<div style="display:flex; min-height:600px;">
    <div style="flex:1; padding:32px 40px 32px 40px;">
        <!-- ====== 검색 폼 ====== -->
        <form action="/public/books/total" method="get" class="search-bar">
            <select name="type">
                <option value="title" ${param.type == 'title' ? 'selected' : ''}>책제목</option>
                <option value="author" ${param.type == 'author' ? 'selected' : ''}>저자</option>
                <option value="publisher" ${param.type == 'publisher' ? 'selected' : ''}>출판사</option>
                <option value="isbn" ${param.type == 'isbn' ? 'selected' : ''}>ISBN</option>
            </select>
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
            <button type="submit">검색</button>
        </form>

        <!-- ====== 검색 상태 안내 ====== -->
        <div style="margin-bottom:8px;">
            <c:choose>
                <c:when test="${empty param.keyword}">
                    <span style="color:#999;">검색어를 입력하고 검색해 주세요.</span>
                </c:when>
                <c:otherwise>
                    전체 <b>
                        <c:choose>
                            <c:when test="${not empty bookList}">${fn:length(bookList)}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </b> 건
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ====== 결과 테이블 ====== -->
        <c:if test="${not empty param.keyword}">
            <c:choose>
                <c:when test="${empty bookList}">
                    <div style="text-align:center; color:#999; margin-top:30px;">검색 결과가 없습니다.</div>
                </c:when>
                <c:otherwise>
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
                                <td style="text-align:center;">${stat.index + 1}</td>
                                <td class="book-cover">
                                    <c:choose>
                                        <c:when test="${not empty book.imageLink}">
                                            <img src="${book.imageLink}" alt="표지" style="width:64px; height:auto; border:1px solid #dde9f2;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/images/no-image.jpg" style="width:64px; height:auto; border:1px solid #eee;">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
        <!-- ★★★ DB등록 도서만 상세 링크 ★★★ -->
	<td class="book-title">
    	<c:set var="normIsbn" value="${book.isbn != null ? fn:replace(book.isbn, '-', '') : ''}" />
    	<c:set var="isDbBook" value="false" />
    	<c:forEach var="dbIsbn" items="${dbIsbnList}">
        	<c:if test="${normIsbn eq dbIsbn}">
            	<c:set var="isDbBook" value="true" />
        	</c:if>
    	</c:forEach>
    	<c:choose>
        	<c:when test="${isDbBook}">
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
                <c:when test="${curStatus eq '0'}">
                    <span style="color:#2cbb2c;">대여가능</span>
                </c:when>
                <c:when test="${curStatus eq '1'}">
                    <span style="color:#fa6400;">대여중</span>
                </c:when>
                <c:otherwise>
                    <span style="color:#999;">대여불가</span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>
                    </table>

                    <!-- ====== 페이징 (최대 5개 + 이전/다음 버튼) ====== -->
                    <c:if test="${totalPage > 1}">
                        <c:set var="startPage" value="${(currentPage-1)/5*5 + 1}" />
                        <c:set var="endPage" value="${startPage+4 < totalPage ? startPage+4 : totalPage}" />
                        <div style="text-align:center; margin-top:10px;">
                            <c:if test="${currentPage > 1}">
                                <a href="?type=${param.type}&keyword=${param.keyword}&pageNo=${currentPage - 1}">&lt;</a>
                            </c:if>
                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <a href="?type=${param.type}&keyword=${param.keyword}&pageNo=${i}"
                                   style="${i == currentPage ? 'font-weight:bold;color:#176bb9;' : ''}">
                                    ${i}
                                </a>
                            </c:forEach>
                            <c:if test="${currentPage < totalPage}">
                                <a href="?type=${param.type}&keyword=${param.keyword}&pageNo=${currentPage + 1}">&gt;</a>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
</div>
