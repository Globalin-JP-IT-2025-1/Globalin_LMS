<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="ko_KR" />
<fmt:formatDate value="${expiresDate.time}" pattern="yyyy-MM-dd HH:mm" />


<style>
#blackList, #blackList > tr, th, td {
	border: 1px solid var(--main-color);
	border-collapse: collapse;
	border-spacing: 0;
}

#blackList th {
	background-color: var(--gray-color);
}

.blackList_summary,
.blackList_content {
	width: 100%;
}

.blackList_content button {
	width: 100px;
}

</style>


<!-- 조회 -->
<!-- @GetMapping("/admin/tokens") -->
<div class="blackList_summary">
	전체 ${fn:length(blackList)} 건
	<select id="filterType">
		<option id="ft_expirated">만료됨</option>
		<option id="ft_acessToken">액세스 토큰</option>
		<option id="ft_refreshToken">리프레시 토큰</option>
	</select>
	<button id="filtering">필터링</button>
</div>
<br>
<div class="blackList_content">
	<table id="blackList">
		<tr>
			<th>NO</th>
			<th>토큰 ID</th>
			<th>토큰 타입</th>
			<th>토큰</th>
			<th>유효기간</th>
			<th>회원 정보 삭제</th>
		</tr>
	
		<c:forEach var="token" items="${blackList}">
			<c:set var="cnt" value="${cnt + 1}" />
			<tr>
				<td>${cnt}</td>
				<td>${token.blacklistedTokenId}</td>
				<td>
					<c:choose>
						<c:when test="${token.type eq 0}">
						Access Token
						</c:when>
						<c:when test="${token.type eq 1}">
						Refresh Token
						</c:when>
						<c:otherwise>
						알 수 없음
						</c:otherwise>
					</c:choose>
				</td>
				<td>${token.token}</td>
				<td>${token.expiresDate}</td>
		        <td><button onclick="deleteToken('${token.blacklistedTokenId}')">삭제</button></td>
			</tr>
		</c:forEach>
	
	</table>
</div>

<script type="text/javascript">
function deleteToken(blacklistedTokenId) {
	console.log("blacklistedTokenId : " + blacklistedTokenId);
	
	Swal.fire({
        icon: 'success',
        title: '삭제 성공!',
        text: 'blacklistedTokenId: ' + blacklistedTokenId + ' 삭제 완료!',
        confirmButtonText: '확인'
    });
}
</script>
