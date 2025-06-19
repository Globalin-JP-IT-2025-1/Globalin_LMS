<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="articleList" value="${articleList}" />

<!-- 게시글 목록 조회 - qna -->
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${fn:length(articleList)}</strong> 건</div>
        <div>
	        <select class="form-select form-select-sm d-inline-block w-auto" id="searchType">
	            <option id="st_title">제목</option>
	            <option id="st_content">내용</option>
	        </select>
	        <input type="text" class="form-control form-control-sm d-inline-block w-auto" id="searchKeyword">
	        <button class="btn btn-primary btn-sm" id="search">검색</button>
	    </div>
    </div>
    <div class="overflow-x-auto" >
    <table class="table mt-3 table-hover">
        <thead class="table-primary">
            <tr>
                <th>NO</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>댓글수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="i" begin="0" end="${fn:length(articleList) - 1}" step="1">
            	
                <tr onclick="location.href='/public/articles/qna/${articleList[i].articlesId}'">
                    <td>${i + 1}</td>
                    <td>${articleList[i].title}</td>
                    <td>${authorList[i].name}(${authorList[i].username})</td>
                    <td>${articleList[i].viewCount}</td>
                    <td>${articleList[i].replyCount}</td>
                             
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>