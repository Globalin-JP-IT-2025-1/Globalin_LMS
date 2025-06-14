<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- 회원 정보 -->
<c:set var="memberInfo" value="${sessionScope.mInfo}" />

<!-- 페이지 타이틀 & URI 설정 -->
<c:choose>
	<c:when test="${pageTitleCode eq '0'}">
		<c:set var="pageGroupTitle">
			<spring:message code="menu.0.title" />
		</c:set>
		<c:set var="currentPageTitle" value="${pageGroupTitle}" />
	</c:when>
	<c:otherwise>
		<c:set var="groupCode" value="${fn:substring(pageTitleCode, 0, 1)}" />
		<c:set var="pageCode" value="${fn:substring(pageTitleCode, 1, 2)}" />
		
		<c:set var="pageGroupTitle">
			<spring:message code="menu.${groupCode}.title" />
		</c:set>

		<c:set var="pageSubTitle1">
			<spring:message code="menu.${groupCode}.con1" />
		</c:set>
		<c:set var="pageSubTitle1Uri">
			<spring:message code="menu.${groupCode}.con1.uri" />
		</c:set>

		<c:set var="pageSubTitle2">
			<spring:message code="menu.${groupCode}.con2" />
		</c:set>
		<c:set var="pageSubTitle2Uri">
			<spring:message code="menu.${groupCode}.con2.uri" />
		</c:set>

		<c:set var="pageSubTitle3">
			<spring:message code="menu.${groupCode}.con3" />
		</c:set>
		<c:set var="pageSubTitle3Uri">
			<spring:message code="menu.${groupCode}.con3.uri" />
		</c:set>

		<c:set var="pageSubTitle4" value="" />
		<c:set var="pageSubTitle4Uri" value="" />
		<c:catch var="error">
		    <c:set var="message">
		        <spring:message code="menu.${groupCode}.con4"/>
		    </c:set>
		</c:catch>
		
		<c:if test="${empty error}">
			<c:set var="pageSubTitle4">
				<spring:message code="menu.${groupCode}.con4" />
			</c:set>
			<c:set var="pageSubTitle4Uri">
				<spring:message code="menu.${groupCode}.con4.uri" />
			</c:set>
		</c:if>

		<c:choose>
			<c:when test="${pageCode eq '1'}">
				<c:set var="currentPageTitle" value="${pageSubTitle1}" />
				<c:set var="currentPageUri" value="${pageSubTitle1Uri}" />
			</c:when>
			<c:when test="${pageCode eq '2'}">
				<c:set var="currentPageTitle" value="${pageSubTitle2}" />
				<c:set var="currentPageUri" value="${pageSubTitle2Uri}" />
			</c:when>
			<c:when test="${pageCode eq '3'}">
				<c:set var="currentPageTitle" value="${pageSubTitle3}" />
				<c:set var="currentPageUri" value="${pageSubTitle3Uri}" />
			</c:when>
			<c:when test="${pageCode eq '4' and not empty pageSubTitle4}">
				<c:set var="currentPageTitle" value="${pageSubTitle4}" />
				<c:set var="currentPageUri" value="${pageSubTitle4Uri}" />
			</c:when>
			<c:otherwise>
				<c:set var="currentPageTitle" value="${pageGroupTitle}" />
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Globalin Library : ${currentPageTitle}</title>


<!-- Bootstrap CSS & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
		
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/layout.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<!-- Sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

					<%@ include file="common/m_layout.jsp"%>
				</c:otherwise>
			</c:choose>
		</main>

		<footer>
			<%@ include file="common/footer.jsp"%>
		</footer>
	</div>

	<button id="scrollUpBtn"><i class="bi bi-caret-up-fill"></i></button>

	<script
		src="${pageContext.request.contextPath}/resources/static/js/layout.js"></script>

	<script type="text/javascript">
		window.onload = function() {
			var alertType = "${alertType}";
			var alertMessage = "${alertMessage}";
			if (alertMessage && alertMessage.trim() !== "") {
				Swal.fire({
					icon : alertType,
					title : '알림',
					text : alertMessage,
					confirmButtonText : '확인'
				});
			}
		};
	</script>

</body>
</html>
