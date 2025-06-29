<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
.sitemap {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 60px;
  padding: 50px 30px;
}

.sitemap > div {
  border: 1px solid #ddd;
  border-radius: 16px;
  background-color: #ffffff;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
  padding: 30px 30px;
  width: 300px;
  min-height: 240px;
  transition: all 0.2s ease-in-out;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

.sitemap > div:hover {
  transform: translateY(-6px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.sitemap_title {
  font-size: 1.4rem;
  font-weight: 700;
  color: #003366;
  margin-bottom: 20px;
  border-bottom: 2px solid #003366;
  padding-bottom: 10px;
}

.sitemap_content ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sitemap_content li {
  margin: 10px 0;
}

.sitemap_content a {
  text-decoration: none;
  color: #0056b3;
  font-weight: 500;
  transition: color 0.15s ease-in-out;
}

.sitemap_content a:hover {
  color: #0d6efd;
  text-decoration: underline;
}
</style>

<div class="sitemap">
	<div>
		<div class="sitemap_title"><spring:message code="menu.1.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
       				<a href="/public/books/total" 
       					class="m_submenu_active_target" 
       					data-submenu="mSubmenu1"><spring:message code="menu.1.con1" /></a>
       			</li>
				<li><a href="/public/books/class" 
	          			class="m_submenu_active_target" 
	          			data-submenu="mSubmenu2"><spring:message code="menu.1.con2" /></a>
	          	</li>
	          	<li><a href="/public/books/loan" 
	          			class="m_submenu_active_target" 
	          			data-submenu="mSubmenu3"><spring:message code="menu.1.con3" /></a>
	          	</li>
	          	<li><a href="/public/books/like" 
	          			class="m_submenu_active_target" 
	          			data-submenu="mSubmenu4"><spring:message code="menu.1.con4" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.2.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/articles/not" 
	        			class="m_submenu_active_target" 
	        			data-submenu="mSubmenu1"><spring:message code="menu.2.con1" /></a>
	        	</li>
	          	<li><a href="/public/articles/faq" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.2.con2" /></a>
		        </li>
	          	<li><a href="/public/articles/qna" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.2.con3" /></a>
		        </li>
	          	<li><a href="/private/articles/req" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu4"><spring:message code="menu.2.con4" /></a>
		        </li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.3.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/private/members/${h_membersId}" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.3.con1" /></a>
	          	</li>
	          	<li><a href="/private/members/${h_membersId}/book-history" 
	          			class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.3.con2" /></a>
			    </li>
	          	<li><a href="/private/members/${h_membersId}/book-like" 
	          			class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.3.con3" /></a>
			    </li>
	          	<li><a href="/private/members/${h_membersId}/book-req"  
	          			class="m_submenu_active_target" 
			          	data-submenu="mSubmenu4"><spring:message code="menu.3.con4" /></a>
			    </li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.4.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/etc/41" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.4.con1" /></a>
	          	</li>
	          	<li><a href="/public/etc/42" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.4.con2" /></a>
	          	</li>
	          	<li><a href="/public/etc/43" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.4.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.5.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/etc/51" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.5.con1" /></a>
	          	</li>
	          	<li><a href="/public/etc/52" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.5.con2" /></a>
	          	</li>
	          	<li><a href="/public/etc/53" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.5.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.7.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/etc/71" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.7.con1" /></a>
	          	</li>
	          	<li><a href="/public/etc/72" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.7.con2" /></a>
	          	</li>
	          	<li><a href="/public/etc/73" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.7.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.6.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/auth/login" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.6.con1" /></a>
	          	</li>
	          	<li><a href="/public/members/check" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.6.con2" /></a>
	          	</li>
	          	<li><a href="/public/members/repass" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.6.con3" /></a>
	          	</li>
	          	<li><a href="/public/members/register" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu4"><spring:message code="menu.6.con4" /></a>
	          	</li>
			</ul>
		</div>
	</div>
	
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div>
		<div class="sitemap_title"><spring:message code="menu.9.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/admin/books" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu1"><spring:message code="menu.9.con1" /></a>
	          	</li>
	          	<li><a href="/admin/articles" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu2"><spring:message code="menu.9.con2" /></a>
	          	</li>
	          	<li><a href="/admin/members" 
			          	class="m_submenu_active_target" 
			          	data-submenu="mSubmenu3"><spring:message code="menu.9.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>
</sec:authorize>

</div>
