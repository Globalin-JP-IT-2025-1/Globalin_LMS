<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<table id="userList">
	<tr>
		<th>ID</th>
		<th>Name</th>
		<th>Email</th>
	</tr>

	<c:forEach var="userList" items="${userList}">
		<tr>
			<td>${userList.id}</td>
			<td>${userList.name}</td>
			<td>${userList.email}</td>
		</tr>
	</c:forEach>

</table>

