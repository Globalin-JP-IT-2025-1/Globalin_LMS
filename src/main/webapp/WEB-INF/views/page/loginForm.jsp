<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="utf-8" />


<form action="/user/loginCheck" method="POST" onsubmit="return checkBlank(this)">
	<table id="loginForm">
		<tr>
			<td>ID : </td>
			<td><input type="text" name="userid" max="30"></td>
		</tr>

		<tr>
			<td>PW : </td>
			<td><input type="password" name="password" max="30"></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>

