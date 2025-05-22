<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form action="/user/register" method="POST" onsubmit="return checkBlank(this)">
	<table id="regForm">
		<tr>
			<td>dbID : </td>
			<td>자동생성</td>
		</tr>

		<tr>
			<td>이름 : </td>
			<td><input type="text" name="name" max="30"></td>
		</tr>

		<tr>
			<td>이메일 : </td>
			<td><input type="email" name="email" max="50"></td>
		</tr>
		
		<tr>
			<td>ID : </td>
			<td><input type="text" name="userid" max="30">&nbsp;&nbsp;<a href="">중복확인</a></td>
		</tr>

		<tr>
			<td>PW : </td>
			<td><input type="password" name="password" max="30"></td>
		</tr>

		<tr>
			<td colspan="2" align="right"><input type="submit" value="회원가입"></td>
		</tr>
	</table>
</form>

