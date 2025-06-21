<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="article" value="${article}" />
<c:set var="replyList" value="${replyList}" />

<c:set var="totalCount" value="${totalCount}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="currentPage" value="${currentPage}" />

<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${(currentPage - 1) / blockSize * blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1 > totalPages ? totalPages : startPage + blockSize - 1}" />

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/articleDetail.css">

<!-- 게시글 상세 조회 - 공지사항 -->
<div class="container-fluid">
	<div class="mb-3 row">
		<div class="col-sm-10">
			<input class="form-control mb-3 mt-4 articleTitle" style="border: none;" id="titleView" type="text" readonly value="${article.title}"/>
			<hr class="border border-1 opacity-50">
	    </div>
	    <div class="col-sm-10 mb-3">
	        <div class="articleDetail_div1">
				<label class="col-form-label" >작성자</label>
	            <label class="col-form-label">
	            	<c:set var="a_fullname" value="${article.authorFullname}" />
                   	<c:set var="a_username" value="${article.authorUsername}" />
                   	<!-- 로그인하지 않은 경우 -->
                    <sec:authorize access="isAnonymous()">
						<c:choose>
                    		<c:when test="${articleList[i].authorId == 0}">
                    			${a_fullname}(${a_username})
                    		</c:when>
                    		<c:otherwise>
								${fn:substring(a_fullname, 0, 1)}**(${a_username})
                    		</c:otherwise>
                    	</c:choose>
                    </sec:authorize>
                    <!-- 로그인한 경우 -->
                    <sec:authorize access="isAuthenticated()">
                       	<c:choose>
                          	<c:when test="${replyList[i].authorId == userDetails.membersId 
                       					or userDetails.membersId == 0 
			                          	or articleList[i].authorId == 0}">    
                            	${a_fullname}(${a_username})
                            </c:when>
                            <c:otherwise>
								${fn:substring(a_fullname, 0, 1)}**(${a_username})
                            </c:otherwise>
                         </c:choose>
                    </sec:authorize>
	            </label>
	            <div class="vr"></div>
	            <label class="col-form-label" >조회수</label>
	            <label class="col-form-label">${article.viewCount}</label>
	            <div class="vr"></div>
	            <label class="col-form-label" >등록일</label>
	            <label class="col-form-label"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd" /></label>
			</div>
			<hr class="border border-1 opacity-50">
		</div>
		<div class="col-sm-10">
			<textarea class="form-control mb-4" style="border: none; resize: none;" id="contentView" readonly rows="7">${article.content}</textarea>
		</div>
		<div class="btndiv">
			<!-- 현재 로그인한 사용자가 관리자인 경우에만 보이기 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
		        <button class="btn btn-primary updateBtn" type="button" id="editButton" onclick="enableEdit()">수정</button>
		        <button type="submit" id="cancleButton" class="btn btn-light cancleBtn" style="display: none;" onclick="cancleEdit(${article.articlesId})">취소</button>
			</sec:authorize>
			<form action="/private/articles/req/${article.articlesId}" method="post" id="articleForm" >
	            <input type="hidden" name="_method" value="PUT">
	            <input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
				<input type="hidden" id="title" name="title" readonly value="${article.title}"><!-- 게시글 수정 - 서버 송신1 -->
				<textarea id="content" name="content" readonly hidden="true">${article.content}</textarea><!-- 게시글 수정 - 서버 송신2 -->
	            <button type="submit" class="btn btn-primary saveBtn" id="saveButton" style="display: none;">저장</button>            
			</form>
		</div>
	</div>
</div>

<div class="container-fluid mb-5 card articleDetail_div2">   
	<label class="form-label mt-4 mb-3">댓글(전체 <strong>${fn:length(replyList)}</strong> 건)</label>
	<!-- 댓글 작성 폼 -->
	<div class="articleDetail_div3">
		<form action="/private/replies/${articlesId}/req" method="post">
			<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			<c:choose>
				<c:when test="${not empty userDetails}">
					<div class="replies_writebox position-relative">
						<div class="position-relative w-100">
							<textarea class="form-control" name="content" id="replyContent" maxlength="500" rows="3"></textarea><!-- 댓글 작성 - 서버 송신1 -->
							<div class="char-count-inside" id="charCount">0 / 500</div>
							<sec:authorize access="hasRole('ROLE_USER')">
								<input type="hidden" name="authorId" value="${userDetails.membersId}" readonly><!-- 댓글 작성 - 서버 송신2 -->
							</sec:authorize>
						</div>
						<button class="btn btn-outline-primary addBtn" type="submit">등록</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="replies_writebox position-relative">
						<div class="position-relative w-100">
							<textarea class="form-control bg-light" id="replyContent" maxlength="500" rows="3" readonly>로그인 필요</textarea>
							<div class="char-count-inside" id="charCount">0 / 500</div>
						</div>
						<button class="btn btn-outline-secondary addBtn" type="submit" disabled>등록불가</button>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
      
		<hr class="border border-1 opacity-50">
	</div>
   
	<div class="articleDetail_div4">   
		<!-- 댓글 목록 조회 -->
		<c:if test="${fn:length(replyList) > 0}">
			<div class="position-relative mt-2 mb-4">
				<c:forEach var="i" begin="0" end="${fn:length(replyList) - 1}" step="1">
					<div class="d-flex justify-content-between align-items-center mb-2" style="position: relative;">
						<div>
							<!-- 댓글 작성자 -->
							<label class="form-label replyLabel">
								<c:set var="r_fullname" value="${replyList[i].authorFullname}" />
		                    	<c:set var="r_username" value="${replyList[i].authorUsername}" />
		                    	<!-- 로그인하지 않은 경우 -->
			                    <sec:authorize access="isAnonymous()">
									<c:choose>
			                    		<c:when test="${r_username eq 'admin'}">
			                    			${r_fullname}(${r_username})
			                    		</c:when>
			                    		<c:otherwise>
											${fn:substring(r_fullname, 0, 1)}**(${r_username})
			                    		</c:otherwise>
			                    	</c:choose>
			                    </sec:authorize>
			                    <!-- 로그인한 경우 -->
			                    <sec:authorize access="isAuthenticated()">
			                       	<c:choose>
			                          	<c:when test="${replyList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">                     
			                            	${r_fullname}(${r_username})
			                            </c:when>
			                            <c:otherwise>
											${fn:substring(r_fullname, 0, 1)}**(${r_username})
			                            </c:otherwise>
			                         </c:choose>
			                    </sec:authorize>
			                </label>
	                       
	                       	<!-- 댓글 내용: status=2(게스트인 경우와 작성자가 아닌 경우 비공개, 작성자와 관리자인 경우 공개), 0(전체 공개), 1(가져오지 않음) -->
	                       	<label class="form-label">
		                       	<c:choose>
		                            <c:when test="${replyList[i].status == 0}">
			                    		<span class="text-dark">${replyList[i].content}</span>
			                    	</c:when>
			                    	
		                            <c:when test="${replyList[i].status == 2}">
		                            	<sec:authorize access="isAnonymous()">
				                            <span class="text-secondary"><i class="bi bi-lock"></i>&nbsp;비공개 댓글입니다.</span>
				                        </sec:authorize>
				                        <sec:authorize access="isAuthenticated()">
		                            		<c:choose>
		                            			<c:when test="${replyList[i].authorId != userDetails.membersId}">
						                            <span class="text-secondary"><i class="bi bi-lock"></i>&nbsp;비공개 댓글입니다.</span>
		                            			</c:when>
		                            			<c:when test="${replyList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">
						                    		<span class="text-dark">${replyList[i].content}</span>
		                            			</c:when>
		                            		</c:choose>
		                            	</sec:authorize>
			                    	</c:when>
			                    </c:choose>
	                     	</label>
	                     	
	                     	<!-- 작성날짜: 월.일 시:초 -->
							<label class="form-label replyLabel">
								<fmt:formatDate value="${replyList[i].updateDate}" pattern="MM.dd hh:mm:ss" />
							</label>
						</div>
						
						<!-- 댓글 비밀↔공개 전환 스위치 + 삭제 버튼 : 현재 로그인한 사용자와 댓글 작성자가 일치하는 경우 또는 관리자만 공개 -->
						<sec:authorize access="isAuthenticated()">
				            <c:if test="${replyList[i].authorId == userDetails.membersId or userDetails.membersId == 0}">
								
								<!-- 오른쪽 스위치 + 삭제 버튼 -->
								<div class="d-flex align-items-center" style="gap: 10px;">
									<!-- 댓글 비밀↔공개 스위치 폼 -->
									<form id="statusForm-${replyList[i].repliesId}" method="post">
					                    <input type="hidden" name="_method" value="PUT" />
					                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                    <div class="form-check form-switch">
					                       	<input class="form-check-input" type="checkbox"  id="statusSwitch-${replyList[i].repliesId}"
					                               ${replyList[i].status == 2 ? "" : "checked"}
						                           onchange="submitStatus('${article.articlesId}', '${replyList[i].repliesId}')">
				                        </div>
				                  	</form>
				                  	
				                   	<!-- 댓글 삭제 버튼 (soft del) -->
					                <form action="/private/replies/${article.articlesId}/req/${replyList[i].repliesId}/1" method="post">
					                    <input type="hidden" name="_method" value="PUT" />
					                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                    <button type="submit" class="hideBtn"><i class="bi bi-trash3"></i></button>
					                </form>
				               	</div>
				            </c:if>
			            </sec:authorize>
	            	</div>
	            	<hr class="border opacity-50">
	           	</c:forEach>
	        </div>
	        
	        <!-- 댓글 페이징 -->
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
		</c:if>
	</div>
</div>

<div class="d-none"> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="testUpdate()">수정 테스트</button>
</div>

<script>
    function enableEdit() {
        document.getElementById("titleView").removeAttribute("readonly");
        document.getElementById("titleView").removeAttribute("style");
        document.getElementById("contentView").removeAttribute("readonly");
        document.getElementById("contentView").removeAttribute("style");

        document.getElementById("editButton").style.display = "none"; // 수정 버튼 숨김
        document.getElementById("saveButton").style.display = "inline-block"; // 저장 버튼 표시
        document.getElementById("cancleButton").style.display = "inline-block"; // 수정 버튼 표시
        
    }
    
    
    document.getElementById("titleView").addEventListener("blur", function () {
        document.getElementById("title").value = this.value;
    });
    document.getElementById("contentView").addEventListener("blur", function () {
        document.getElementById("content").value = this.value;
    });
    
    
    function cancleEdit(articlesId) {
       const confirmCancel = confirm("정말 취소하겠습니까?");
       if (confirmCancel) {
            window.location.href = '/private/articles/req/'+articlesId;
       }
    }
    
    function testUpdate() {
          // 빈 값 여부
          vailFormData();
          
          var title = document.getElementById("title").value;
          var content = document.getElementById("content").value;
       
          alert(" title: " + title 
                + " content: " + content);
          
          alert("수정 요청데이터 테스트 완료");

       }
    
    // 빈 칸 검사
    function vailFormData() {
       
       if (document.getElementById("titleView").value.trim() === "") {
           alert("제목을 작성해주세요.");
           document.getElementById("titleView").focus();
           return;
       }
       
       if (document.getElementById("contentView").value.trim() === "") {
           alert("내용을 작성해주세요.");
           document.getElementById("contentView").focus();
           return;
       }
      
        
    }
    //공개 비공개
   function submitStatus(articlesId, replyId) {
      const isChecked = document.getElementById("statusSwitch-" + replyId).checked;
      const status = isChecked ? 0 : 2;
     
      if (!articlesId || !replyId) {
          alert("경로 생성 실패: articlesId 또는 repliesId가 비어있습니다.");
          return;
     }
   
        const form = document.getElementById("statusForm-" + replyId);
        form.action = '/private/replies/'+articlesId+'/req/'+replyId+'/'+status;
        form.submit();
   }
    
   document.addEventListener("DOMContentLoaded", function () {
        var content = document.getElementById("replyContent");
        var charCount = document.getElementById("charCount");

        content.addEventListener("input", function () {
          var length = content.value.length;
          charCount.textContent = length + " / 500";
        });
      });

</script>