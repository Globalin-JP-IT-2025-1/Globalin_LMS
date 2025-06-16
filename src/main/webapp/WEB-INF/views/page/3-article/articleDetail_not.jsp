<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="article" value="${article}" />
<c:set var="a_author" value="${a_author}" />
<c:set var="replyList" value="${replyList}" />
<c:set var="r_authorList" value="${r_authorList}" />

<!-- 게시글 상세 조회 - 공지사항 -->

<ul>
	<li>제목 : ${article.title}</li>
	<li>작성자 : ${author.name} ($author.username)</li>
	<li>작성날짜 : ${article.updateDate}</li>
	<li>내용 : ${article.content}</li>

</ul>
<br>
<!-- 댓글 작성 폼 -->
<form action="/private/replies/{articlesId}" method="post">
	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="text" name="content" id="content" maxlength="500"> <input type="submit" value="작성">
</form>
<br>
<b>댓글 목록</b>
<br>
<div>전체 <strong>${fn:length(replyList)}</strong> 건</div>
<br>
<!-- 댓글 목록 조회 -->
<c:if test="${fn:length(replyList) > 0}">
<ul>
	<c:forEach var="i" begin="0" end="${fn:length(replyList) - 1}" step="1">
		<li>${replyList[i].content} - ${r_AuthorList[i].name}(${r_AuthorList[i].username}) / <fmt:formatDate value="${replyList[i].updateDate}" pattern="MM-dd hh:mm" /> </li>
	</c:forEach>
</ul>
</c:if>