<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="memberList" value="${memberList}" />
<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<meta name="csrf-token" content="${_csrf.token}">

<style>
.membersList tr {
	cursor: pointer !important;
}

/* 공통 스타일 */
.membersList td, .membersList th {
	white-space: normal !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
	text-align: center;
}

/* 각 열 너비 */
.membersList td:nth-child(1), .membersList th:nth-child(1) { min-width: 60px !important; }
.membersList td:nth-child(2), .membersList th:nth-child(2) { min-width: 60px !important; }
.membersList td:nth-child(3), .membersList th:nth-child(3) { min-width: 120px !important; }
.membersList td:nth-child(4), .membersList th:nth-child(4) { min-width: 120px !important; }
.membersList td:nth-child(5), .membersList th:nth-child(5) { min-width: 120px !important; }
.membersList td:nth-child(6), .membersList th:nth-child(6) { min-width: 100px !important; }
.membersList td:nth-child(7), .membersList th:nth-child(7) { min-width: 100px !important; }
.membersList td:nth-child(8), .membersList th:nth-child(8) { min-width: 100px !important; }
.membersList td:nth-child(9), .membersList th:nth-child(9) { min-width: 120px !important; }
.membersList td:nth-child(10), .membersList th:nth-child(10) { min-width: 120px !important; }
.membersList td:nth-child(11), .membersList th:nth-child(11) { min-width: 50px !important; }
.membersList td:nth-child(12), .membersList th:nth-child(12) { min-width: 50px !important; }

.membersList td:nth-child(1), .membersList th:nth-child(1) { max-width: 60px !important; }
.membersList td:nth-child(2), .membersList th:nth-child(2) { max-width: 60px !important; }
.membersList td:nth-child(3), .membersList th:nth-child(3) { max-width: 120px !important; }
.membersList td:nth-child(4), .membersList th:nth-child(4) { max-width: 120px !important; }
.membersList td:nth-child(5), .membersList th:nth-child(5) { max-width: 120px !important; }
.membersList td:nth-child(6), .membersList th:nth-child(6) { max-width: 100px !important; }
.membersList td:nth-child(7), .membersList th:nth-child(7) { max-width: 100px !important; }
.membersList td:nth-child(8), .membersList th:nth-child(8) { max-width: 100px !important; }
.membersList td:nth-child(9), .membersList th:nth-child(9) { max-width: 120px !important; }
.membersList td:nth-child(10), .membersList th:nth-child(10) { max-width: 120px !important; }
.membersList td:nth-child(11), .membersList th:nth-child(11) { max-width: 50px !important; }
.membersList td:nth-child(12), .membersList th:nth-child(12) { max-width: 50px !important; }

</style>

<!-- 게시글 목록 조회 - 관리자 -->
<div class="container mt-4">
	<!-- 요약 & 검색창 -->
    <div class="d-flex justify-content-between align-items-center">
        <div>전체 <strong>${totalCount}</strong> 건</div>
        <div>
	        <select class="form-select form-select-sm d-inline-block w-auto" id="searchType">
	            <option id="st_cardnum">카드번호</option>
	            <option id="st_username">아이디</option>
	            <option id="st_name">성함</option>
	            <option id="st_mobile">핸드폰번호</option>
	        </select>
	        <input type="text" class="form-control form-control-sm d-inline-block w-auto" id="searchKeyword">
	        <button class="btn btn-primary btn-sm" id="search">검색</button>
	    </div>
    </div>
    
    <!-- 글 목록 -->
    <div class="overflow-x-auto">
	    <table class="table mt-3 table-hover membersList">
	        <thead>
	            <tr>
	                <th>NO</th>
	                <th>회원ID</th>
	                
	                <th>이름<br>(아이디)</th>
	                <th>이메일</th>
	                <th>연락처</th>
	                
	                <th>상태</th>
	                <th>카드번호</th>
	                <th>대출현황</th>
	                
	                <th>가입날짜</th>
	                <th>탈퇴날짜</th>
	                
	                <th>카드<br>등록</th>
	                <th>삭제</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${empty memberList}">
	        			<td colspan="12" style="text-align: center;">조회된 회원이 없습니다</td>
	        		</c:when>
		        	<c:when test="${not empty memberList}">
				       	<c:forEach var="i" begin="0" end="${fn:length(memberList) - 1}" step="1">
			                <tr onclick="location.href='/private/members/${memberList[i].membersId}'">
			                    <td>${i + (currentPage * 7) - 6}</td>
			                    <td>${memberList[i].membersId}</td>
			                    
			                    <td>${memberList[i].name}(${memberList[i].username})</td>
			                    <td>${memberList[i].email}</td>
			                    <td>${memberList[i].mobile}</td>
			                    
			                    <td>
				                    <c:choose>
				                    	<c:when test="${memberList[i].status eq 0}">
				                    		<p class="badge text-bg-light">준회원</p>
				                    	</c:when>
				                    	<c:when test="${memberList[i].status eq 1}">
				                    		<p class="badge text-bg-success">정회원</p>
				                    	</c:when>
				                    	<c:when test="${memberList[i].status eq 2}">
				                    		<p class="badge text-bg-danger">대출정지</p>
				                    	</c:when>
				                    	<c:when test="${memberList[i].status eq 3}">
				                    		<p class="badge text-bg-secondary">탈퇴회원</p>
				                    	</c:when>
				                    	<c:when test="${memberList[i].status eq 9}">
				                    		<p class="badge text-bg-primary">관리자</p>
				                    	</c:when>
				                    	<c:otherwise>
				                    		알 수 없음
				                    	</c:otherwise>
				                    </c:choose>
			                    </td>
			                    <td>${memberList[i].cardNum}</td>
			                    <td>${memberList[i].loanCount}</td>
			                    
			                    <td><fmt:formatDate value="${memberList[i].joinDate}" pattern="yyyy-MM-dd" /></td>
			                    <td><fmt:formatDate value="${memberList[i].leaveDate}" pattern="yyyy-MM-dd" /></td>
			                    <td>
									<c:if test="${memberList[i].status eq 0}">
										<button class="btn btn-warning btn-sm"
										        data-bs-toggle="modal"
										        data-bs-target="#returnModal"
										        onclick="setUpgradeFormAction(${memberList[i].membersId})">
										    <i class="bi bi-box-arrow-in-down-left"></i>
										</button>
									</c:if>			                    	
			                    </td>
			                    <td>
			                    	<form action="/admin/members/${memberList[i].membersId}" method="post" class="d-inline">
									  	<input type="hidden" name="_method" value="DELETE" />
									  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
											<i class="bi bi-trash"></i>
										</button>
									</form>
			                    </td>
			                </tr>
		            	</c:forEach>
		        	</c:when>
	        	</c:choose>
	        </tbody>
	    </table>
    </div>
    
    <!-- upgrade 모달 -->
	<div class="modal fade" id="upgradeModal" tabindex="-1" aria-labelledby="upgradeModalLabel" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<form id="upgradeForm" method="post">
	        		<div class="modal-header">
		          		<h5 class="modal-title" id="upgradeModalLabel">회원 등급 변경</h5>
		         		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	        		</div>
	        		
	        		<div class="modal-body">
	          			<div class="mb-3">
	            			<label for="memberCard" class="form-label">회원카드 번호</label>
	            			<div class="input-group">
	              				<input type="text" class="form-control" name="cardNo" id="memberCard" required>
              					<button type="button" class="btn btn-outline-secondary" onclick="generateAndFillCardNo()">발급하기</button>
            				</div>
	         			</div>
	          			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	        		</div>
	        		
	        		<div class="modal-footer">
	          			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	          			<button type="submit" class="btn btn-primary">변경하기</button>
        			</div>
	      		</form>
	    	</div>
	  	</div>
	</div>

    
    <!-- 페이징 -->
    <div class="d-flex justify-content-center mt-4">
	    <nav aria-label="Page navigation">
	        <ul class="pagination">
	
	            <c:if test="${currentPage > 1}">
	                <li class="page-item">
	                    <a class="page-link" href="?page=${currentPage - 1}">이전</a>
	                </li>
	            </c:if>
	
	            <c:forEach var="i" begin="${startPage}" end="${endPage}">
				    <li class="page-item ${i == currentPage ? 'active' : ''}">
				        <a class="page-link" href="?page=${i}">${i}</a>
				    </li>
				</c:forEach>
	
	            <c:if test="${currentPage < totalPages}">
	                <li class="page-item">
	                    <a class="page-link" href="?page=${currentPage + 1}">다음</a>
	                </li>
	            </c:if>
	        </ul>
	    </nav>
	</div>
    
    
</div>

<script type="text/javascript">

// 회원 등급 업 처리
function setUpgradeFormAction(memberId) {
  	const form = document.querySelector('#upgradeModal form');
  	form.action = '/admin/members/' + memberId + '/upgrade';
}

// 회원카드 랜덤 발급기 : 발행일8자리-랜덤일련번호(uuid)6자리 조합
function generateCardNumber() {
	// 1. 발행일 (오늘 날짜 기준)
	const today = new Date();
	const yyyy = today.getFullYear();
	const mm = String(today.getMonth() + 1).padStart(2, '0');
	const dd = String(today.getDate()).padStart(2, '0');
	const datePart = `${yyyy}${mm}${dd}`;
	
	// 2. 랜덤 6자리 (UUID 일부)
	const uuidPart = crypto.randomUUID().replace(/-/g, '').slice(0, 6);
	
	return datePart + '-' + uuidPart;
}

// 자동 채워지기
//const upgradeModal = document.getElementById('upgradeModal');
//upgradeModal.addEventListener('show.bs.modal', () => {
//	generateCardNumber();
//});

</script>