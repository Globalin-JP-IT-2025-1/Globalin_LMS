<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="user" value="${user}" />

<table>
	<tr>
		<td>dbID :</td>
		<td>${name.id}</td>
	</tr>

	<tr>
		<td>이름 :</td>
		<td>${name.name}</td>
	</tr>

	<tr>
		<td>이메일 :</td>
		<td>${name.email}</td>
	</tr>

	<tr>
		<td>ID :</td>
		<td>${name.userid}</td>
	</tr>

	<tr>
		<td>PW :</td>
		<td>${name.password}</td>
	</tr>

	<tr>
		<td colspan="2" align="right"><a href="/">홈으로</a></td>
	</tr>
</table>

