<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
/* 스타일은 이전 통합검색/주제별과 동일하게 */
.table-books { width:100%; border-collapse:collapse; font-size:1.03em; table-layout:fixed; }
.table-books th, .table-books td { padding:16px 14px; text-align:left; border-bottom:1.7px solid #cbeaff;}
.table-books th { background:#eaf6ff; color:#176bb9; font-weight:bold;}
.table-books td { background:#f6fbfd; font-size:1em;}
.table-books td.book-cover { width:90px; min-width:90px; text-align:center; background:#fff;}
.table-books td.book-title { width:340px; min-width:260px; max-width:900px; font-weight:500; background:#fff; white-space:normal; word-break:break-all;}
.table-books td.book-status { width:110px; min-width:90px; text-align:center; font-weight:bold; color:#1c7ccd; background:#eaf6ff; letter-spacing:1.5px; font-size:1.06em;}
.table-books tr:hover td { background:#e2f1fa;}
</style>

<div style="font-size:1.25em; font-weight:bold; margin-bottom:18px; color:#217bb9;">
    🏆 대출 베스트 100 도서
</div>

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
                        <img src="${book.imageLink}" style="width:64px; height:auto; border:1px solid #dde9f2;">
                    </c:when>
                    <c:otherwise>
                        <img src="/resources/images/no-image.jpg" style="width:64px; height:auto; border:1px solid #eee;">
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="book-title">
                <a href="/public/books/detail?booksId=${book.booksId}" style="color:#217bb9; text-decoration:underline;">
                    ${book.title}
                </a>
            </td>
            <td>${book.author}</td>
            <td>${book.publisher}</td>
            <td class="book-status">
                <c:choose>
                    <c:when test="${book.status eq 0}"><span style="color:#2cbb2c;">대여가능</span></c:when>
                    <c:when test="${book.status eq 1}"><span style="color:#fa6400;">대여중</span></c:when>
                    <c:otherwise><span style="color:#999;">대여불가</span></c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
<c:if test="${empty bookList}">
    <div style="text-align:center; color:#999; margin-top:30px;">도서 정보가 없습니다.</div>
</c:if>
