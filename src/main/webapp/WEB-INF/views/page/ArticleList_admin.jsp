<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:formatDate value="${createDate.time}" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${updateDate.time}" pattern="yyyy-MM-dd" />

<style>
#articleList, #articleList > tr, th, td {
	border: 1px solid var(--main-color);
	border-collapse: collapse;
	border-spacing: 0;
}

#articleList th {
	background-color: var(--gray-color);
}

.articleList_summary,
.articleList_content {
	width: 100%;
}

.articleList_content button {
	width: 100px;
}

</style>

<!-- 조회 -->
<!-- @GetMapping("/admin/articles") -->
<div class="articleList_summary">
	전체 ${fn:length(articleList)} 건
	<select id="searchType">
		<option id="st_username">아이디</option>
		<option id="st_title">제목</option>
		<option id="st_content">내용</option>
	</select>
	<input type="text" id="searchKeyword"><button id="search">검색</button>
</div>
<br>
<div class="articleList_content">
	<table id="articleList">
		<tr>
			<th>NO</th>
			<th>ARTICLES_ID</th>
			<th>AUTHOR_ID (members.membersId)</th>
			<th>작성자 이름 (members.name)</th>
			<th>작성자 id (members.username)</th>
			<th>CATEGORY</th>
			<th>TITLE</th>
			<th>CONTENT</th>
			<th>CREATE_DATE</th>
			<th>UPDATE_DATE</th>
			<th>REPLY_COUNT</th>
			<th>VIEW_COUNT</th>
		</tr>
	
		<c:forEach var="article" items="${articleList}">
			<c:set var="cnt" value="${cnt + 1}" />
			<tr>
				<td>${cnt}</td>
				<td>${article.articlesId}</td>
				<td>${article.authorId}</td>
				<td>${article.name}</td>
				<td>${article.username}</td>
				<td>${article.category}</td>
				<td>${article.content}</td>
				<td>${article.createDate}</td>
				<td>${article.updateDate}</td>
				<td>${article.replyCount}</td>
				<td>${article.viewCount}</td>
				<td>${article.isSecret}</td>
			</tr>
		</c:forEach>
	
	</table>
</div>
