<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Globalin Library : ${pageTitle}</title>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/layout.css">

</head>
<body>
	<div class="layout">
		<header>
			<div class="header">
				<jsp:include page="common/header.jsp" />
			</div>
		</header>
	
		<main>
			<div class="main">
				<jsp:include page="${pagePath}" />
			</div>
		</main>
	
		<footer>
			<div class="footer">
				<jsp:include page="common/footer.jsp" />
			</div>
		</footer>
	</div>

	<script src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>
	
</body>
</html>
