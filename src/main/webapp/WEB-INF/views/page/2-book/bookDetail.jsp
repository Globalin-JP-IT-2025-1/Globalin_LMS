<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ===== 도서 상세 조회 ===== -->
<div class="book-detail-container" style="max-width:820px; margin:32px auto; background:#fff; border-radius:18px; box-shadow:0 2px 10px #e8f1ff;">

    <!-- 오류 메시지 있으면 안내만 출력 -->
    <c:if test="${not empty errorMsg}">
        <div style="color:#e04a4a; font-weight:bold; font-size:1.18em; text-align:center; padding:60px 0;">
            ${errorMsg}
        </div>
    </c:if>
    
    <!-- 정상 도서 데이터가 있을 때만 상세정보 출력 -->
    <c:if test="${not empty book}">
        <div style="display:flex; gap:40px; padding:40px 38px 26px 38px;">
            <!-- 책 표지 이미지 -->
            <img src="${book.imageLink}" style="width:140px;height:auto;border:1.3px solid #dde9f2; background:#f8fafc;">
            
            <!-- 책 상세 정보 -->
            <div style="flex:1;">
                <div style="font-size:2.0em;font-weight:700; color:#217bb9; margin-bottom:10px;">${book.title}</div>
                <div style="margin-bottom:7px;">저자 <b>${book.author}</b> &nbsp;&nbsp;|&nbsp;&nbsp; 출판사 <b>${book.publisher}</b></div>
                <div style="margin-bottom:7px;">카테고리: ${book.category} &nbsp;&nbsp;|&nbsp;&nbsp; ISBN: ${book.isbn}</div>
                <div style="margin-bottom:15px;">
                    상태: 
                    <c:choose>
                        <c:when test="${book.status eq 0}"><span style="color:#22bb55;">대여가능</span></c:when>
                        <c:when test="${book.status eq 1}"><span style="color:#fa6400;">대여중</span></c:when>
                        <c:when test="${book.status eq 2}"><span style="color:#ff3254;">예약중</span></c:when>
                        <c:otherwise><span style="color:#aaa;">비활성</span></c:otherwise>
                    </c:choose>
                </div>
                
               <!-- 찜/대출 버튼 (로그인/상태별 동작은 백엔드에서 분기 구현 필요) -->
			   <div style="margin-bottom:14px;">
					<!-- 찜 버튼은 그대로 -->
    				<form action="/public/books/like" method="post" style="display:inline;">
        				<input type="hidden" name="booksId" value="${book.booksId}">
        				<!-- CSRF 토큰 추가 -->
        				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        				<button type="submit" style="padding:6px 20px; border-radius:7px; border:1.3px solid #176bb9; color:#176bb9; background:#f5fbff; font-weight:600; margin-right:8px; cursor:pointer;">
            				<span style="font-size:1.09em;">&#9734; 찜</span>
        				</button>
    				</form>
    				<!-- 대출 버튼 분기 시작 -->
    				<c:choose>
        				<c:when test="${book.status eq 0}">
            				<!-- 대여가능: 버튼 활성화 -->
            				<form action="/public/books/loan" method="post" style="display:inline;">
                				<input type="hidden" name="booksId" value="${book.booksId}">
                				<!-- CSRF 토큰 추가 -->
                				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                				<button type="submit" style="padding:6px 20px; border-radius:7px; border:1.3px solid #217bb9; color:#fff; background:#217bb9; font-weight:600; cursor:pointer;">
                    				<span style="font-size:1.09em;">대출</span>
                				</button>
            				</form>
        				</c:when>
        				<c:otherwise>
            				<!-- 대여불가: 버튼 비활성 + 안내문구 -->
            				<button disabled style="padding:6px 20px; border-radius:7px; border:1.3px solid #aaa; color:#fff; background:#ccc; font-weight:600; cursor:not-allowed;">
                				<span style="font-size:1.09em;">대출불가</span>
            				</button>
        				</c:otherwise>
    				</c:choose>
				</div>
                
                <!-- 책 설명/소개 -->
                <div style="background:#f8fafc; border-radius:8px; padding:17px 18px; color:#447; font-size:1.07em;">
                    <c:out value="${book.description}" default="등록된 책 소개가 없습니다."/>
                </div>
            </div>
        </div>
        <hr style="margin:0 36px 0 36px; border:0; border-top:1.1px solid #d4e4f3;">
        
        <!-- ===== 리뷰 작성 폼 ===== -->
        <div style="padding:24px 38px 8px 38px;">
            <form action="/public/reviews/add" method="post" style="display:flex; gap:14px; align-items:center;">
                <input type="hidden" name="booksId" value="${book.booksId}">
                <!-- CSRF 토큰 추가 -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="text" name="title" id="addForm-review-title" maxlength="30"
                    placeholder="리뷰 제목" style="flex:0 0 180px; padding:7px 13px; border-radius:8px; border:1.3px solid #d5dff2;">
                <input type="text" name="content" id="addForm-content-title" maxlength="100"
                    placeholder="리뷰 내용을 입력하세요" style="flex:1; padding:7px 13px; border-radius:8px; border:1.3px solid #d5dff2;">
                <button type="submit" style="padding:7px 20px; border-radius:8px; background:#176bb9; color:#fff; font-weight:600; border:none;">
                    등록
                </button>
            </form>
        </div>
        
        <!-- ===== 리뷰 목록 ===== -->
        <div style="padding:16px 38px 30px 38px;">
            <h4 style="margin:12px 0 10px 0; color:#217bb9; font-size:1.14em;">한줄평/리뷰</h4>
            <c:if test="${not empty reviewList}">
                <table style="width:100%; border-collapse:collapse;">
                    <tr style="background:#f6fbfd; color:#176bb9;">
                        <th style="width:140px; padding:7px 0;">작성자</th>
                        <th style="text-align:left;">제목</th>
                        <th style="text-align:left;">내용</th>
                        <th style="width:110px;">작성일</th>
                    </tr>
                    <c:forEach var="review" items="${reviewList}">
                        <tr>
                            <td style="text-align:center;">${review.writer}</td>
                            <td>${review.title}</td>
                            <td>${review.content}</td>
                            <td style="text-align:center; color:#666;">${review.createdDate}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            <c:if test="${empty reviewList}">
                <div style="color:#aaa; margin-top:14px;">등록된 리뷰가 없습니다.</div>
            </c:if>
        </div>
    </c:if>
</div>
