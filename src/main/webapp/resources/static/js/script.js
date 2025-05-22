/* 회원가입 폼, 로그인 폼 빈칸 체크 */
function checkBlank(form) {
	let id = form["id"].value.trim();
	let pw = form["pw"].value.trim();

	if (name === "") {
		alert("⚠️ 이름을 입력해주세요!");
		form["name"].focus();
		return false;
	}

	if (email === "") {
		alert("⚠️ 이메일을 입력해주세요!");
		form["email"].focus();
		return false;
	}

	// 회원가입 폼의 경우 2항목 더 확인
	if (form.id === "regForm") {
		let name = form["name"].value.trim();
		let email = form["email"].value.trim();

		if (id === "") {
			alert("⚠️ ID를 입력해주세요!");
			form["id"].focus();
			return false;
		}

		if (pw === "") {
			alert("⚠️ 비밀번호를 입력해주세요!");
			form["pw"].focus();
			return false;
		}
	}

	return true;
}

