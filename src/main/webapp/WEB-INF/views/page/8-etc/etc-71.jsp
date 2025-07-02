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
       					data-menu-id="mSubmenu1" 
   						onclick="handleNavigation(event, this)"><spring:message code="menu.1.con1" /></a>
       			</li>
				<li><a href="/public/books/class" 
						data-menu-id="mSubmenu2" 
   						onclick="handleNavigation(event, this)"><spring:message code="menu.1.con2" /></a>
	          	</li>
	          	<li><a href="/public/books/loan" 
	          			data-menu-id="mSubmenu3" 
   						onclick="handleNavigation(event, this)"><spring:message code="menu.1.con3" /></a>
	          	</li>
	          	<li><a href="/public/books/like" 
	          			data-menu-id="mSubmenu4"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.1.con4" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.2.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li><a href="/public/articles/not" 
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.2.con1" /></a>
	        	</li>
	          	<li><a href="/public/articles/faq"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.2.con2" /></a>
		        </li>
	          	<li><a href="/public/articles/qna"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.2.con3" /></a>
		        </li>
	          	<li><a href="/private/articles/req"
	          			data-menu-id="mSubmenu4"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.2.con4" /></a>
		        </li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.3.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/private/members/${h_membersId}"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.3.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/private/members/${h_membersId}/book-history"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.3.con2" /></a>
			    </li>
	          	<li>
	          		<a href="/private/members/${h_membersId}/book-like"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.3.con3" /></a>
			    </li>
	          	<li>
	          		<a href="/private/members/${h_membersId}/book-req"
	          			data-menu-id="mSubmenu4"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.3.con4" /></a>
			    </li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.4.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/public/etc/41"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.4.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/42"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.4.con2" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/43"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.4.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.5.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/public/etc/51"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.5.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/52"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.5.con2" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/53"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.5.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.7.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/public/etc/71"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.7.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/72"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.7.con2" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/etc/73"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.7.con3" /></a>
	          	</li>
			</ul>
		</div>
	</div>

	<div>
		<div class="sitemap_title"><spring:message code="menu.6.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/public/auth/login"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.6.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/members/check"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.6.con2" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/members/repass"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.6.con3" /></a>
	          	</li>
	          	<li>
	          		<a href="/public/members/register"
	          			data-menu-id="mSubmenu4"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.6.con4" /></a>
	          	</li>
			</ul>
		</div>
	</div>
	
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div>
		<div class="sitemap_title"><spring:message code="menu.9.title" /></div>
		<div class="sitemap_content">
			<ul>
				<li>
					<a href="/admin/books"
						data-menu-id="mSubmenu1"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.9.con1" /></a>
	          	</li>
	          	<li>
	          		<a href="/admin/articles"
	          			data-menu-id="mSubmenu2"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.9.con2" /></a>
	          	</li>
	          	<li>
	          		<a href="/admin/replies"
	          			data-menu-id="mSubmenu3"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.9.con3" /></a>
	          	</li>
	          	<li>
	          		<a href="/admin/members"
	          			data-menu-id="mSubmenu4"
   						onclick="handleNavigation(event, this)"><spring:message code="menu.9.con4" /></a>
	          	</li>
			</ul>
		</div>
	</div>
</sec:authorize>

</div>


<script>
// etc71 --> 메인 소메뉴 css (a태그)
function handleNavigation(event, element) {
    const menuId = element.getAttribute("data-menu-id");
    const url = element.getAttribute("href");

    if (menuId) {
        sessionStorage.setItem("activeMenuId", menuId);
    }

    // 기본 링크 이동 막고 수동으로 이동
    event.preventDefault();
    if (url) {
        window.location.href = url;
    }
}
</script>
