<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 로그인 폼 -->
<form action="/public/auth/login" method="post" class="w-100">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="hidden" name="username" id="username" value="" readonly>
    <input type="hidden" name="password" id="password" value="" readonly>
    <input type="hidden" name="remember-me" id="rememberMeHidden" value="true" />

        <div class="card shadow-sm w-60 pt-5 my-3">
            <div class="container d-flex flex-column justify-content-center align-items-center loginForm">
                
                <div class="mb-3 col-4 d-flex gap-2">
                    <div class="col-3 d-flex align-items-center">아이디</div>
                    <div class="input-group d-flex align-items-center">
                        <input class="form-control" type="text" id="usernameBox" value="" placeholder="<spring:message code="main.h2.2" />" maxlength="20">
                    </div>
                </div>
                
                <div class="mb-3 col-4 d-flex gap-2">
                    <div class="col-3 d-flex align-items-center">비밀번호</div>
                    <div class="input-group d-flex align-items-center">
                        <input class="form-control" type="password" id="passwordBox" value="" placeholder="<spring:message code="main.h2.3" />" maxlength="20">
                    </div>
                </div>
                
                <div class="mb-3 col-4 d-flex justify-content-center align-items-center gap-2">
                    <input class="form-check-input" type="checkbox" id="autoLoginBox" checked>
                    <label class="form-check-label" for="autoLoginBox"><spring:message code="main.h2.4" /></label>
                </div>
                
                <div class="mb-3 col-4 d-flex justify-content-center align-items-center gap-2">
                    <input class="mb-3 btn btn-primary" type="submit" value="<spring:message code="main.h2.14" />">
                </div>
            </div>
        </div>
</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
(function () {
	// CDN 방식이 로드되지 않는 경우
    if (typeof jQuery === "undefined") {
        var script = document.createElement("script");
        script.src = "/js/jquery-3.6.0.min.js";
        script.onload = initLoginScript;
        document.head.appendChild(script);
    } else {
        initLoginScript();
    }

    function initLoginScript() {
        $(function () {
            const $form = $("form");
            const $usernameBox = $("#usernameBox");
            const $passwordBox = $("#passwordBox");
            const $autoLoginBox = $("#autoLoginBox");

            const $usernameHidden = $("#username");
            const $passwordHidden = $("#password");
            const $rememberMeHidden = $("#rememberMeHidden");

            $autoLoginBox.on("change", function () {
                $rememberMeHidden.prop("disabled", !this.checked);
            });

            $form.on("submit", function (e) {
                if ($.trim($usernameBox.val()) === "") {
                    alert("아이디가 비어있습니다");
                    $usernameBox.focus();
                    e.preventDefault();
                    return;
                }

                if ($.trim($passwordBox.val()) === "") {
                    alert("비밀번호가 비어있습니다");
                    $passwordBox.focus();
                    e.preventDefault();
                    return;
                }

                $usernameHidden.val($usernameBox.val());
                $passwordHidden.val($passwordBox.val());
            });
        });
    }
})();

</script>

