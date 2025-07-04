<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="hasRole('ROLE_USER')">
    <sec:authentication property="principal" var="userDetails" />
</sec:authorize>

<!-- 게시글 작성 폼 - 희망 도서 신청 -->
<div class="container my-4">
	<div class="card shadow-sm py-4 px-4">
		<div class="pb-4">
			<h4>글 작성</h4>
		</div>
		<div class="d-flex flex-column align-items-center gap-3 w-100">
			<!-- 제목 -->
			<div class="form-floating w-100">
				<input type="text" class="form-control" id="titleView" placeholder="제목을 입력해주세요." maxlength="30" />
				<label for="titleView">제목</label>
			</div>
	
			<!-- 내용 -->
			<div class="form-floating w-100">
		        <textarea class="form-control" id="contentView" placeholder="내용을 입력해주세요." maxlength="300" rows="7" style="height: auto !important;"></textarea>
		        <label for="contentView">내용</label>
			</div>
	
			<!-- 도서 찾기 링크 -->
			<div class="w-100 text-start">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#bookListModal">
  					도서 찾기
  				</button>
			</div>
			
			<!-- 외부 API 도서 찾기 모달 -->
			<!-- 검색창 + 버튼 -->
			<!-- <div class="input-group mb-3">
			  	<input type="text" id="bookKeyword" class="form-control" placeholder="도서 제목, 저자 등 입력">
			  	<button class="btn btn-primary" id="searchBookBtn">도서 검색</button>
			</div> -->
			
			<!-- 도서 리스트 모달 -->
			<!-- <div class="modal fade" id="bookListModal" tabindex="-1" aria-labelledby="bookListModalLabel" aria-hidden="true">
			  	<div class="modal-dialog modal-lg">
			    	<div class="modal-content">
			      		<div class="modal-header">
				        	<h5 class="modal-title" id="bookListModalLabel">📚 도서 검색 결과</h5>
				        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			      		</div>
				      	<div class="modal-body">
				        	<div id="bookListContent" class="list-group">
				          		<div class="text-center text-muted">검색어를 입력하세요.</div>
				        	</div>
				      	</div>
			    	</div>
			  	</div>
			</div> -->
			
			<!-- 비밀글 여부 선택 -->
			<div class="form-check align-self-start">
				<input class="form-check-input" type="checkbox" id="secretView" />
				<label class="form-check-label" for="secretView">
				  비밀글로 설정하기
				</label>
			</div>
			
			<form action="/private/articles/req" method="post" id="articleForm">
				<!-- CSRF -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
				<!-- 서버 전송용 hidden 필드 -->
				<!-- 자동 입력 -->
				<input type="hidden" name="authorId" value="${userDetails.membersId}" readonly />
				<input type="hidden" name="category" value="req" readonly />
				
				<!-- 폼 입력 -->
				<input type="hidden" id="title" name="title" readonly />
				<textarea hidden="true" readonly id="content" name="content"></textarea>
				<input type="hidden" id="status" name="status" value="0" readonly />
		
				<!-- 저장 버튼 -->
				<div class="w-100 d-flex justify-content-end">
					<button type="submit" class="btn btn-primary px-4" id="saveButton">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>


<div class="d-none"> <!-- 테스트시 d-none 해제 -->
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
    
    /* document.getElementById('searchBookBtn').addEventListener('click', function () {
      const keyword = document.getElementById('bookKeyword').value.trim();
      const content = document.getElementById('bookListContent');

      if (!keyword) {
        content.innerHTML = '<div class="text-center text-muted">검색어를 입력해주세요.</div>';
        new bootstrap.Modal(document.getElementById('bookListModal')).show();
        return;
      }

      content.innerHTML = '<div class="text-center text-muted">불러오는 중...</div>';
      new bootstrap.Modal(document.getElementById('bookListModal')).show();

      fetch(`/admin/books/api?type=keyword&keyword=${encodeURIComponent(keyword)}&currentPage=1`)
        .then(res => res.json())
        .then(data => {
          if (!data.bookList || data.bookList.length === 0) {
            content.innerHTML = '<div class="text-center text-muted">검색 결과가 없습니다.</div>';
            return;
          }

          content.innerHTML = '';
          data.bookList.forEach(book => {
            const item = document.createElement('div');
            item.className = 'list-group-item';
            item.innerHTML = `
              <div class="d-flex">
                <img src="${book.imageLink}" alt="표지" style="height: 100px; margin-right: 15px;">
                <div>
                  <h5>${book.title}</h5>
                  <p class="mb-1 text-muted">${book.author} | ${book.publisher}</p>
                  <small>ISBN: ${book.isbn}</small><br>
                  <a href="${book.description}" target="_blank" class="btn btn-sm btn-outline-secondary mt-2">상세보기</a>
                </div>
              </div>
            `;
            content.appendChild(item);
          });
        })
        .catch(err => {
          console.error(err);
          content.innerHTML = '<div class="text-danger text-center">도서 정보를 불러오는 데 실패했습니다.</div>';
        });
    }); */
 </script>
