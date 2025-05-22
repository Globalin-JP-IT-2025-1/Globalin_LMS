<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Globalin Library : ${pageTitle}</title>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/style.css">
</head>
<body>
	
	<header style="background-color: rgb(255, 255, 215);">
		<jsp:include page="common/header.jsp" />
	</header>

	<main>
		<h2>${pageTitle}</h2>
		<jsp:include page="${pagePath}" />
	</main>

	<footer style="background-color: rgb(255, 255, 215);">
		<jsp:include page="common/footer.jsp" />
	</footer>
	
	<script src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>
</body>
</html>
