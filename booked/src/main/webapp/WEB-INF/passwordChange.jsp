<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
	<br>
	<h2>Change Password for ${user.firstName}</h2>
		<form action="updatePassword.do?id=${user.id}" method="POST">
			<div class="row justify-content-center">
				<div class="col">
				<label for="username" class="form-label">Username </label>
					<input type="text" value="${user.username}" />
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col">
				<label for="password" class="form-label">Old Password </label>
					<input type="password" name="password" />
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col">
				<label for="newPassword" class="form-label">New Password </label>
					<input type="password" name="newPassword" />
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col">
					<button class="btn btn-dark" type="submit">Submit</button>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>