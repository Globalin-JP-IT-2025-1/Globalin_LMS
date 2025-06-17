<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="article" value="${article}" />
<c:set var="a_author" value="${a_author}" />
<c:set var="replyList" value="${replyList}" />
<c:set var="r_authorList" value="${r_authorList}" />

<style>
.updateBtn {
	background-color: var(--main-color);
	color: white;
	border-radius: 10px;
}

.btndiv {
	display: flex;
	flex-direction: colum;
	justify-content: flex-end;
	
}
</style>

<!-- 게시글 상세 조회 - 공지사항 -->
<div class="container-fluid">
	<div class="mb-3 row">
		<div class="col-sm-10">
			<input class="form-control" id="titleView" type="text" readonly value="${article.title}"/>
		</div>
		<div class="mb-3 display-flex justify-content-flex-end">
			<label class="col-sm-1 col-form-label" >작성자</label>
			<label class="form-label ">${a_author.name} (${a_author.username}) </label>
			<label class="col-sm-1 col-form-label" >조회수</label>
			<label class="form-label">${fn:length(replyList)}</label>
			<label class="col-sm-1 col-form-label" >등록일</label>
			<label class="form-label"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd" /></label>
		</div>
		<div class="col-sm-10">
			<textarea class="form-control" id="contentView" readonly rows="7">${article.content}</textarea>
		</div>
		<div class="btndiv">
			<button class="updateBtn" type="button" id="editButton" onclick="enableEdit()">수정</button>
			<form action="/admin/articles/not" method="post" id="articleForm" >
				<input type="hidden" name="_method" value="PUT">
				<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			    <input type="hidden" id="title" readonly value="${article.title}">
			    <textarea id="content" readonly hidden="true">${article.content}</textarea>
				<button type="submit" id="saveButton" style="display: none;">저장</button>				
			</form>
			<button type="submit" id="cancleButton" style="display: none;" onclick="cancleEdit(${article.articlesId})">취소</button>
		</div>
	</div>
</div>



<div class="container-fluid card">	
	<label class="form-label">댓글(전체 <strong>${fn:length(replyList)}</strong> 건)</label>
	<!-- 댓글 작성 폼 -->
	<div>
		<form action="/private/replies/{articlesId}" method="post">
			<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" hidden="true"/>
			<input type="text" name="content" id="content" maxlength="500"> <input type="submit" value="작성">
		</form>
	</div>
	
	<div>
		
		
		<!-- 댓글 목록 조회 -->
		<c:if test="${fn:length(replyList) > 0}">
		<div>
			<c:forEach var="i" begin="0" end="${fn:length(replyList) - 1}" step="1">
				<label class="form-label">${r_authorList[i].name}(${r_authorList[i].username})</label>
				<label class="form-label">${replyList[i].content} - <fmt:formatDate value="${replyList[i].updateDate}" pattern="MM-dd hh:mm" /> </label>
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
        document.getElementById("contentView").removeAttribute("readonly");

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
</script>