<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Globalin Library : ${pageTitle}</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/layout.css">

</head>
<body>
	<div class="layout">
		<header>
			<%@ include file="common/header.jsp"%>
		</header>

		<main>
			<jsp:include page="${pagePath}" />
		</main>

		<footer>
			<%@ include file="common/footer.jsp"%>
		</footer>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>

</body>
</html>
