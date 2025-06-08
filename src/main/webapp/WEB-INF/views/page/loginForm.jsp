<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
</style>

<!-- 로그인 폼 -->
<ul id="loginForm">
	<li>id : <input type="text" id="username" placeholder="아이디 입력" maxlength="10">
	<li>password : <input type="password" id="password" placeholder="비밀번호 입력" maxlength="20"></li>
</ul>

<button onclick="loginProc()">로그인</button> <!-- POST /public/login -->

<script>
// 로그인 요청
function loginProc() {
	// 폼 데이터 가져오기
    const login = {
    	username: document.getElementById("username").value,
    	password: document.getElementById("password").value,
    };
	
	console.log(document.getElementById("username").value);
	console.log(document.getElementById("password").value);
	
	Swal.fire({
        title: "로그인 요청",
        text: "로그인 하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "확인",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/public/auth/login`, { 
            	method: "POST",
            	headers: { "Content-Type": "application/json" },
                body: JSON.stringify(login) // 객체를 JSON 문자열로 변환
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire("로그인 성공", "로그인 성공 하였습니다.", "success").then(() => {
                    	location.href = "/"; // 홈으로
                    });
                } else {
                    Swal.fire("오류 발생", "로그인 실패 하였습니다.", "error");
                }
            })
            .catch(error => {
                Swal.fire("오류 발생", "서버 오류가 발생했습니다.", "error");
                console.error("Error:", error);
            });
        }
    });
}

</script>