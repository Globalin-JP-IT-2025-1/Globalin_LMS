<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 게시글 작성 폼 - 자주 묻는 질문 -->
<div class="container my-4">
	<div class="card shadow-sm py-4 px-4">
		<div class="pb-4">
			<h4>글 작성</h4>
		</div>
		<div class="d-flex flex-column align-items-center gap-3 w-100">
			<!-- 질문 -->
			<div class="form-floating w-100">
				<input type="text" class="form-control" id="titleView" placeholder="제목을 입력해주세요." maxlength="100" />
				<label for="titleView">질문</label>
			</div>
	
			<!-- 답변 -->
			<div class="form-floating w-100">
		        <textarea class="form-control" id="contentView" placeholder="내용을 입력해주세요." maxlength="1000" rows="7" style="height: auto !important;"></textarea>
		        <label for="contentView">답변</label>
			</div>
			
			<!-- 비밀글 여부 선택 -->
			<div class="form-check align-self-start">
				<input class="form-check-input" type="checkbox" id="secretView" />
				<label class="form-check-label" for="isPrivate">
				  비밀글로 저장하기
				</label>
			</div>
	
			<form action="/admin/articles/faq" method="post" id="articleForm">
				<!-- CSRF -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
				<!-- 서버 전송용 hidden 필드 -->
				<input type="hidden" id="title" name="title" readonly />
				<textarea hidden="true" readonly id="content" name="content"></textarea>
				<input type="hidden" id="status" name="status" readonly />
		
				<!-- 저장 버튼 -->
				<div class="w-100 d-flex justify-content-end">
					<button type="submit" class="btn btn-primary px-4" id="saveButton">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class=""> <!-- 테스트시 d-none 해제 -->
	<button onclick="vailFormData()">빈 값 검사</button>
	<button onclick="testAdd()">등록 테스트</button>
</div>

<script>
    document.getElementById("titleView").addEventListener("blur", function () {
        document.getElementById("title").value = this.value;
    });
    document.getElementById("contentView").addEventListener("blur", function () {
        document.getElementById("content").value = this.value;
    });
    document.getElementById("secretView").addEventListener("change", function () {
    	if (this.checked) {
	        document.getElementById("status").value = 2; // 비밀글
    	} else {
	        document.getElementById("status").value = 0; // 일반글
    	}
    });
    
    function testAdd() {
          // 빈 값 여부
          vailFormData();
          
          var title = document.getElementById("title").value;
          var content = document.getElementById("content").value;
          var status = document.getElementById("status").value;
          
          alert(" title: " + title 
                + " content: " + content
                + " status: " + status);
          
          alert("등록 요청데이터 테스트 완료");

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