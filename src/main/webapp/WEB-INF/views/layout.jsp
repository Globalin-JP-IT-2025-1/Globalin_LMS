<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Globalin Library : ${pageTitle}</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/layout.css">

<!-- Bootstrap CSS & Icons -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet" /> -->

</head>
<body>
	<div class="layout">
		<header>
			<%@ include file="common/header.jsp"%>
		</header>
		
		<main>
			<c:choose>
				<c:when test="${pagePath eq 'page/home.jsp'}">
					<jsp:include page="page/home.jsp" />
				</c:when>
				<c:otherwise>
					<%-- <div class="m_submenu">
						<%@ include file="common/m_submenu.jsp" %>
					</div> --%>
	
					<%@ include file="common/m_layout.jsp" %>
				</c:otherwise>
			</c:choose>
		</main>
		
		<footer>
			<%@ include file="common/footer.jsp"%>
		</footer>
	</div>

	<button id="scrollUpBtn">⬆ 위로</button>

	<script
		src="${pageContext.request.contextPath}/resources/static/js/layout.js"></script>

</body>
</html>
