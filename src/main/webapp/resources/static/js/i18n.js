let currentLang = 'ko';
let messages = {};

function loadLanguage(lang) {
	fetch(`/i18n/${lang}.json`)
		.then(res => res.json())
		.then(data => {
			messages = data;
			updateTexts();
		});
}

function updateTexts() {
	document.getElementById('helloText').textContent = messages.hello;
	document.getElementById('byeText').textContent = messages.bye;
}

document.getElementById('langSelector').addEventListener('change', (e) => {
	currentLang = e.target.value;
	loadLanguage(currentLang);
});

// 초기 언어 로드
loadLanguage(currentLang);
