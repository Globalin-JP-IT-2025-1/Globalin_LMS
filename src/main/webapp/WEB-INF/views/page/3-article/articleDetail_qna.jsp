<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 게시글 상세 조회 - qna -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="article" value="${article}" />
<c:set var="author" value="${a_author}" />
<c:set var="replyList" value="${replyList}" />
<c:set var="r_authorList" value="${r_authorList}" />


<style>
.container-fluid {
	margin-left:25px;
}
.updateBtn {
	border: 0;
	background-color: var(--main-color) !important;	
}

.saveBtn {
	border: 0;
	background-color: var(--main-color) !important;
	margin-left: 10px;
}

.cancleBtn {
	border: 0;

}

.btndiv {
	display: flex;
	flex-direction: colum;	
	justify-content: flex-end;
	width: 83%;
}

.articleTitle {
	font-size: 1.7em;
	font-weight: bold; 
	text-align: center;
}


.articleDetail_div1 >label{
	font-size: 0.8em;
	margin: 0 10px 0 10px;
}

.articleDetail_div1{
	display: flex;
    justify-content: flex-end;
    align-content: center;
    gap: 20px;	
}
.articleDetail_div1 .vr{
	height: 35px;
}

.articleDetail_div2 {
	width: 915px;
    margin: 35px 20px 0 35px;
}

.articleDetail_div2 >label{
	margin: 0 20px 0 20px;
}

.hideBtn {
	all: unset;
	color: red;
}

.articleDetail_div3 {
	margin: 0 20px 0 20px;
	
}
.articleDetail_div4 {
	margin: 0 20px 0 20px;
}

.replies_writebox {
  margin-bottom: 25px;
  display: flex;
  gap: 10px;
  align-items: flex-start;
}

.replies_writebox .form-control {
  height: 70px;
  padding: 8px;
  padding-bottom: 20px;
  resize: none;
  overflow-y: auto;
  line-height: 1.4;
  white-space: pre-wrap;
  word-break: break-word;
}

/* 글자 수 */
.char-count-inside {
  position: absolute;
  bottom: 6px;
  right: 10px;
  font-size: 0.75rem;
  color: #999;
  pointer-events: none;
}

.addBtn {
  min-width: 100px;
  background-color: var(--main-color) !important;
  color: white;
  border: 0;
  height: 70px;
}

.replyLabel {
	color: gray;
}
</style>

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
				<label class="col-form-label">${author.name} (${author.username}) </label>
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
			<button class="btn btn-primary updateBtn" type="button" id="editButton" onclick="enableEdit()">수정</button>
			<button type="submit" id="cancleButton" class="btn btn-light cancleBtn" style="display: none;" onclick="cancleEdit(${article.articlesId})">취소</button>
			
			<form action="/admin/articles/not" method="post" id="articleForm" >
				<input type="hidden" name="_method" value="PUT">
				<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			    <input type="hidden" id="title" readonly value="${article.title}">
			    <textarea id="content" readonly hidden="true">${article.content}</textarea>
				<button type="submit" class="btn btn-primary saveBtn" id="saveButton" style="display: none;">저장</button>				
			</form>
		</div>
	</div>
</div>



<div class="container-fluid mb-5 card articleDetail_div2">	
	<label class="form-label mt-4 mb-3">댓글(전체 <strong>${fn:length(replyList)}</strong> 건)</label>
	<!-- 댓글 작성 폼 -->
	<div class="articleDetail_div3">
		<form action="/private/replies/${articlesId}" method="post">
			<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			<div class="replies_writebox position-relative">
			  <div class="position-relative w-100">
			    <textarea class="form-control" id="replyContent" maxlength="500" rows="3"></textarea>
			    <div class="char-count-inside" id="charCount">0 / 500</div>
			  </div>
			  <button class="btn btn-outline-primary addBtn" type="submit">등록</button>
			</div>
		</form>
	</div>
	
	<div class="articleDetail_div4">	
		<!-- 댓글 목록 조회 -->
		<c:if test="${fn:length(replyList) > 0}">
		<div class="position-relative mt-2 mb-4">
			<c:forEach var="i" begin="0" end="${fn:length(replyList) - 1}" step="1">
					<hr class="border border-1 opacity-50">
				   <div class="d-flex justify-content-between align-items-center mb-2" style="position: relative;">
						<div>
					        <label class="form-label replyLabel">${r_authorList[i].name}(${r_authorList[i].username})</label><br>
					       <label class="form-label">
							  <c:choose>
							    <c:when test="${replyList[i].status == 2}">
							      <i class="bi bi-lock"></i>비공개 댓글입니다.
							    </c:when>
							    <c:otherwise>
							      ${replyList[i].content}
							    </c:otherwise>
							  </c:choose>
							</label><br>
					        <label class="form-label replyLabel"><fmt:formatDate value="${replyList[i].updateDate}" pattern="yyyy.MM.dd a hh:mm:ss" /></label>
				      	</div>
			
					<!-- 오른쪽 스위치 + 삭제 버튼 -->
					<div class="d-flex align-items-center" style="gap: 10px;">
						<!-- 공개/비공개 스위치 폼 -->
						<form id="statusForm-${replyList[i].repliesId}" method="post">
							<input type="hidden" name="_method" value="PUT" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox"
								        id="statusSwitch-${replyList[i].repliesId}"
										${replyList[i].status == 2 ? "" : "checked"}
										onchange="submitStatus('${article.articlesId}', '${replyList[i].repliesId}')">
						   	</div>
						</form>
					    	 <!-- 삭제 -->
						<form action="/private/replies/${article.articlesId}/${replyList[i].repliesId}/1" method="post">
							<input type="hidden" name="_method" value="PUT" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						   <button type="submit" class="hideBtn"><i class="bi bi-trash3"></i></button>
					 	</form>
					</div>
			    </div>
			    <hr class="border opacity-50">
			  </c:forEach>
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
            window.location.href = '/public/articles/not/${articlesId}';
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
	  	form.action = '/private/replies/not/'+articlesId+'/'+replyId+'/'+status;
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