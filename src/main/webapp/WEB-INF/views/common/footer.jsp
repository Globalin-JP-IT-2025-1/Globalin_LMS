<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/footer.css">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

<div class="footer">
	<div class="f_1">
		<div class="f1_1">
			<div class="f_title"><a href="/"><spring:message code="main.h4.1" /></a></div>
			<div class="f_title_en">Globalin Library</div>
		</div>

		<div class="f1_2">
			<div><spring:message code="main.h4.2" /></div>
			<div>TEL 02-0000-0000 | FAX 02-0000-0000</div>
			<div>EMAIL contact@globalin-library.com</div>
		</div>

		<div class="f1_3">
			<a href="/public/etc/73" 
				class="m_submenu_active_target" 
				data-submenu="mSubmenu3"><spring:message code="main.h4.3" /></a>
				
            <!-- 관리자만 보임 -->
            <sec:authorize access="hasRole('ROLE_ADMIN')">
				&nbsp;
				<a href="/admin/books" 
					class="m_submenu_active_target" 
					data-submenu="mSubmenu1">Admin Page</a>
            </sec:authorize>
		</div>
	</div>
	<div class="f_2">
		Copyright &copy; 2025. GLOBALIN LIBRARY. All Rights Reserved.
	</div>
</div>


<script
	src="${pageContext.request.contextPath}/resources/static/js/footer.js"></script>



