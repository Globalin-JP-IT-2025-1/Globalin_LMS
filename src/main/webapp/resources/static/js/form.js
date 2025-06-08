/* 폼 빈칸 체크 */
function checkBlankEditMember(form) {
	let password = form["password"].value.trim();
	let confirmPassword = form["confirmPassword"].value.trim();
	let mobile1 = form["mobile1"].value.trim();
	let mobile2 = form["mobile2"].value.trim();
	let mobile3 = form["mobile3"].value.trim();
	let zipcode = form["zipcode"].value.trim();
	let address = form["address"].value.trim();

	if (password === "") {
		alert("⚠️ 비밀번호를 입력해주세요!");
		form["password"].focus();
		return false;
	}

	if (confirmPassword === "") {
		alert("⚠️ 비밀번호 확인을 입력해주세요!");
		form["confirmPassword"].focus();
		return false;
	}

	if (mobile1 === "") {
		alert("⚠️ 연락처를 입력해주세요!");
		form["mobile1"].focus();
		return false;
	}

	if (mobile2 === "") {
		alert("⚠️ 연락처를 입력해주세요!");
		form["mobile2"].focus();
		return false;
	}

	if (mobile3 === "") {
		alert("⚠️ 연락처를 입력해주세요!");
		form["mobile3"].focus();
		return false;
	}

	if (zipcode === "") {
		alert("⚠️ 우편번호를 입력해주세요!");
		form["zipcode"].focus();
		return false;
	}

	if (address === "") {
		alert("⚠️ 주소를 입력해주세요!");
		form["address"].focus();
		return false;
	}


	return true;
}

