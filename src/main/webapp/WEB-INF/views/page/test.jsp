<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<h1>~ i18n 테스트 ~</h1>
<select id="languageSelect">
	<option value="ko">한국어</option>
	<option value="ja">日本語</option>
</select>

<div id="result"></div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $("#languageSelect").change(function() {
        var selectedLang = $(this).val();
        var jsonFile = "${pageContext.request.contextPath}/resources/i18n/" + selectedLang + ".json"; // ko.json 또는 jp.json 선택

        $.ajax({
            url: jsonFile,
            type: "GET",
            dataType: "json",
            success: function(data) {
                $("#result").html(JSON.stringify(data)); // JSON 데이터를 화면에 출력
            },
            error: function() {
                alert("데이터를 불러오는 데 실패했습니다.");
            }
        });
    });
});
</script>


<%-- <script src="${pageContext.request.contextPath}/resources/static/js/i18n.js"></script> --%>
